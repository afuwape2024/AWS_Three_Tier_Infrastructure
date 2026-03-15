from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "service": "customer-service",
        "status": "running",
        "version": "1.0.0"
    })

@app.route("/customers")
def customers():
    return jsonify([
        {"id": 1, "name": "Alice Johnson", "tier": "Gold"},
        {"id": 2, "name": "Bob Smith", "tier": "Silver"},
        {"id": 3, "name": "Carol Davis", "tier": "Platinum"}
    ])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)