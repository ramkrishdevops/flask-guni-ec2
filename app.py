from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Flask with Gunicorn on EC2!"

@app.route("/health")
def health():
    return {"status": "ok"}, 200

