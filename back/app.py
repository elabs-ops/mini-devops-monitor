import subprocess
from flask import Flask, jsonify, redirect, Response

# 1. Création de l'application
app = Flask(__name__)

# 2. Définition d'une route HTTP
@app.route('/')
def home():
    return jsonify({
    	"status": "healthy",
    	"message": "Bienvenue sur l'API de monitoring",
    	"version": "1.0.0",
        "endpoints": {
            "metrics": "/metrics"
        }
	}), 200

@app.route('/metrics')
def call_metrics():
	metrics_json = subprocess.run(
		['./metrics.sh'], 
		capture_output=True, 
		text=True, 
		check=True
	)
	return Response(metrics_json.stdout, mimetype='application/json')

# Dès qu'une erreur 404 survient, on redirige vers /metrics
@app.errorhandler(404)
def page_not_found(error):
	return redirect('/metrics')

# 3. Démarrage du serveur
if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000, debug=True)

