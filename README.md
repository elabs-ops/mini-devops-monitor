# System Metrics Dashboard

Un tableau de bord en temps réel permettant de surveiller les métriques système (CPU, RAM, Disque, Hostname) à l'aide d'une API backend Python/Flask et d'une interface frontend web dynamique.

## Structure du Projet

```text
.
├── back/
│   ├── app.py           
│   ├── Dockerfile          
│   └── requirements.txt   
└── front/
    ├── app.js              
    ├── Dockerfile          
    ├── index.html          
    └── style.css          
```

## Fonctionnalités

* **Hostname** : Affichage du nom de la machine hôte.
* **Charge CPU** : Métriques de charge sur 1m, 5m et 15m.
* **Mémoire RAM** : Suivi de l'utilisation et de la capacité totale (Mo).
* **Espace Disque** : Espace disponible et pourcentage d'utilisation.
* **Temps réel** : Rafraîchissement automatique des données toutes les 10 secondes.


## Technologies

* **Backend** : Python 3.11, Flask, Flask-CORS
* **Scripts Système** : Bash (`procps`, `coreutils`)
* **Frontend** : HTML5, CSS3, JavaScript
* **Serveur Web Frontend** : Nginx (Alpine)
* **Conteneurisation** : Docker

## API Endpoint
```bash
GET /metrics
```

Retourne les métriques de la machine au format JSON :
```json
{
  "hostname": "server-01",
  "cpu_load": { "1m": "0.15", "5m": "0.10", "15m": "0.05" },
  "ram_metrics": { "used_mo": "2048", "total_mo": "8192" },
  "disk_metrics": { "available": "45G", "use_pct": "25%" }
}
```

## Guide de Démarrage avec Docker

### Prérequis
* Docker installé.

### 1. Lancer le Backend (API Flask)
```bash
cd back
docker build -t metrics-backend .
docker run -d -p 5000:5000 --name backend-app metrics-backend
```
* URL de l'API : http://localhost:5000/metrics

### 2. Lancer le Frontend (Serveur Nginx)
```bash
cd front
docker build -t metrics-frontend .
docker run -d -p 8080:80 --name frontend-app metrics-frontend
```
* URL du Dashboard : http://localhost:8080


### 3. Tester l'API
```bash
curl -s http://localhost:5000/metrics | jq
```

### 4. Gestion des Conteneurs
* Vérifier l'état des conteneurs:
```bash
docker ps
```

* Arrêter et supprimer les conteneurs:
```
docker stop backend-app frontend-app
docker rm backend-app frontend-app
```