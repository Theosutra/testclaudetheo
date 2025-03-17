#!/bin/bash

# General information about setup
# Python3.13
# curl/wget
# 7z 

# Définir le répertoire du projet par rapport à l'emplacement du script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT_ROOT="$SCRIPT_DIR/.."
DATA_DIR="$PROJECT_ROOT/data/spatial"

# Créer le répertoire de données s'il n'existe pas
mkdir -p "$DATA_DIR"

echo "Téléchargement des données..."
DOWNLOAD_FILE="/tmp/ADMIN-EXPRESS_3-2__SHP_LAMB93_FXX_2025-02-17.7z"
curl -o "$DOWNLOAD_FILE" "https://data.geopf.fr/telechargement/download/ADMIN-EXPRESS/ADMIN-EXPRESS_3-2__SHP_LAMB93_FXX_2025-02-17/ADMIN-EXPRESS_3-2__SHP_LAMB93_FXX_2025-02-17.7z"

echo "Extraction des fichiers..."
# Utilisation de 7z sur Linux
7z e "$DOWNLOAD_FILE" -o"$DATA_DIR" "COMMUNE.*" "ARRONDISSEMENT.*" "REGION.*" "DEPARTEMENT.*" -r -y

echo "Installation de dbt-duckdb..."
# Installation des dépendances Python
python3 -m pip install dbt-duckdb -r "$PROJECT_ROOT/requirements.txt"

echo "Déplacement vers le répertoire du projet..."
cd "$PROJECT_ROOT" || exit

export DBT_PROJECT_DATA_PATH="$DATA_DIR"

echo "Lancement du projet dbt..."
python3 -m dbt deps
python3 -m dbt run --vars "{\"project_data_path\": \"$DATA_DIR\"}"

echo "Processus terminé avec succès."