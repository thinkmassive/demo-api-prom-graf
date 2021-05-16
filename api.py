from flask import Flask

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/')
def home():
    return "OK\n"

@app.route('/health')
def health():
    return "OK\n"

@app.route('/metrics')
def metrics():
    return "metrics coming soon\n"

app.run()
