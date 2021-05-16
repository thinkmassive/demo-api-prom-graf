# demo-api-prom-graf

## Demo of a flask API w/metrics exporter, prometheus & grafana

```bash
docker-compose up -d

curl localhost:5000/health
curl localhost:5000/metrics
```

  - Prometheus web UI: http://localhost:9090
  - Grafana web UI: http://localhost:3000 (u/p: `admin` / `foobar`)
