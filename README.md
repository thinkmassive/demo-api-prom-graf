# demo-api-prom-graf

## Demo of a flask API w/metrics exporter, prometheus & grafana

```bash
docker build -t demo-api-prom-graf:latest .
docker run -d --net host demo-api-prom-graf:latest

curl localhost:5000
```
