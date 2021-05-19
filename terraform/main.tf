provider "aws" {
  region  = var.region
}

data "aws_vpc" "default" {
  default = true
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}

data "http" "myip" {
  #url = "http://ifconfig.co"
  url = "https://icanhazip.com"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${var.ssh_keypair_name}.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_keypair_name
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "docker_host" {
  ami       = var.docker_host_ami

  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.docker_host_sg.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  user_data                   = data.template_file.user_data.rendered

  root_block_device {
    encrypted             = false
    volume_size           = "10"
    volume_type           = "gp2"
    delete_on_termination = "true"
  }

  lifecycle {
    ignore_changes = [ami, user_data, subnet_id, key_name, ebs_optimized, private_ip, iam_instance_profile]
  }

  tags = var.aws_tags
}

resource "aws_security_group" "docker_host_sg" {
  name   = "docker-host"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH from MyIP"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  ingress {
    description = "API from MyIP"
    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  ingress {
    description = "Grafana from MyIP"
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  ingress {
    description = "Prometheus from MyIP"
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "docker_host_sg"
    },
    var.aws_tags
  )
}

output "public_ip" {
  value = aws_instance.docker_host.public_ip
}
