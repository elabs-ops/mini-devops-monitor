# System Metrics Dashboard

Application de suivi des métriques système en temps réel (CPU, RAM, Disque).

## Technologies
* Backend : Python 3.11 / Flask
* Scripts : Bash (procps, coreutils)
* Conteneurisation : Docker

## Lancement rapide (Backend)

### Prérequis
* Docker installé.

### 1. Construction de l'image Docker
```bash
cd back
docker build -t metrics-api .
```

### 2. Démarrage du conteneur
```bash
docker run -p 5000:5000 metrics-api
```
L'API sera accessible sur http://localhost:5000/metrics


## Tester l'API
```bash
curl http://localhost:5000/metrics
```
