# aperture-flask-demo

## Demo of a flask API w/metrics exporter, prometheus & grafana

This is a very simple containerized demo of Grafana and Prometheus gathering metrics from a Flask API service.

It can be run locally using Docker Compose, or use Terraform to provision an EC2 instance and automatically deploy the docker-compose setup.

### Aperture LSAT proxy

The demo is being extended to run behind an [Aperture](https://github.com/lightninglabs/aperture) reverse proxy that requires paying an [LSAT](https://lsat.tech) invoice to access the protected endpoints.

It works in its current form, tested with a simnet network in [Polar](https://lightningpolar.com). Documentation coming soon.

### Docker Compose Quickstart

```bash
docker-compose up -d

curl localhost:5000/health
curl localhost:5000/metrics
```

  - Prometheus web UI: http://localhost:9090
  - Grafana web UI: http://localhost:3000 (u/p: `admin` / `foobar`)

```bash
# To clean up by stopping and removing all containers, networks, images, and volumes:

docker-compose down
```

### Terraform Quickstart

```bash
cd terraform
terraform init
terraform apply

# To clean up by deleting everything:
terraform destroy
```

The public IP of the EC2 instance will be displayed after a successful apply. You can use that to reach the following:

#### SSH Access

```bash
ssh -i demo_key.pem ubuntu@$public_ip
```

#### Web Access

You can add the public IP to your `/etc/hosts` file with the hostname `demo`:
```bash
# /etc/hosts

1.2.3.4 demo
```
...or substitute the IP for the hostname directly, and use the following links:

  - Grafana: http://demo:3000 (u/p: `admin` / `foobar`)
  - Prometheus: http://demo:9090
  - Flask api: http://demo:5000
    - Healthcheck: http://demo:5000/health
    - BTC-USD price from Coindesk: http://demo:5000/price
    - Fast random delay (0-2 seconds): http://demo:5000/fast
    - Slow random delay (1-5 seconds): http://demo:5000/slow
