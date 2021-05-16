# demo-api-prom-graf

## Demo of a flask API w/metrics exporter, prometheus & grafana

```bash
docker build -t demo-api-prom-graf:latest .
docker run --rm -d \
    --net host \
    --name api \
    demo-api-prom-graf:latest

curl localhost:5000/health
```
