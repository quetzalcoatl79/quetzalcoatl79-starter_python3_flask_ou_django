#!/bin/bash
project_folder="$1"
project_name="$2"

# Vérifier le répertoire du projet
if [ ! -d "$project_folder" ]; then
    echo "Erreur: Le répertoire du projet n'existe pas."
    exit 1
fi

# Aller dans le répertoire du projet
cd "$project_folder"

# Activer l'environnement virtuel (compatible avec Windows, macOS, et Linux)
source "$project_folder"/venv/bin/activate || source "$project_folder"/venv/Scripts/activate

# Installer Django dans l'environnement virtuel
pip install --upgrade pip
pip install django

# Créer un projet Django
django-admin startproject "$project_name"

# Aller dans le répertoire du projet Django
cd "$project_name"

# Appliquer les migrations initiales
python manage.py migrate




# Terminer le script
exit