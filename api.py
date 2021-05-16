from flask import Flask, request
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
#app.config["DEBUG"] = True

metrics = PrometheusMetrics(app)
metrics.info('api_info', 'API info', version='0.1-alpha')

@app.route('/')
def home():
    return "OK\n"

@app.route('/health')
def health():
    return "OK\n"

metrics.register_default(
    metrics.counter(
        'by_path_counter', 'Request count by request paths',
        labels={'path': lambda: request.path}
    )
)

app.run()
