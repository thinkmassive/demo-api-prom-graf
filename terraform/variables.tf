variable "region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ssh_keypair_name" {
  description = "EC2 keypair name"
  default     = "demo_key"
}

variable "aws_tags" {
  description = "Tags to use for all AWS resources"
  type        = map(string)
  default     = {
    OwnedBy = "demo_user"
  }
}

variable "docker_host_ami" {
  description = "EC2 AMI to use for the Docker host"
  default     = "ami-00399ec92321828f5"
}
