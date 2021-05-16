# demo-api-prom-graf

## Demo of a flask API w/metrics exporter, prometheus & grafana

### Docker Compose Quickstart

```bash
docker-compose up -d

curl localhost:5000/health
curl localhost:5000/metrics
```

  - Prometheus web UI: http://localhost:9090
  - Grafana web UI: http://localhost:3000 (u/p: `admin` / `foobar`)

### Terraform Quickstart

```bash
cd terraform
terraform init
terraform apply

# To clean up by deleting everything:
terraform destroy
```

The public IP of the EC2 instance will be displayed after a successful apply. You can use that to reach the following:

  - ssh: `ssh -i demo_key.pem $public_ip` (port 22)
  - api: port 5000
  - grafana: port 3000 (u/p: `admin` / `foobar`)
  - prometheus: port 9090
