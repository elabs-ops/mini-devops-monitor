FROM python:3.11-slim

WORKDIR /usr/src/app

# Installation des outils système (uptime, free)
RUN apt-get update && apt-get install -y procps && \
	rm -rf /var/lib/apt/lists/*

COPY . .

# Création et activation de l'environnement virtuel
RUN python3 -m venv .venv
ENV PATH="/usr/src/app/.venv/bin:$PATH"

# Installation des dépendances et droits d'exécution
RUN pip install -r requirements.txt && \
	chmod +x metrics.sh

ENV PORT=5000
EXPOSE $PORT

CMD ["python3", "app.py"]