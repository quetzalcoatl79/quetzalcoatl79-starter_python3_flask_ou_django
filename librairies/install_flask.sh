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

# Installer Flask et les extensions
pip install --upgrade pip
pip install Flask Flask-SQLAlchemy Flask-WTF Flask-RESTful Flask-Login Flask-Mail Flask-CORS Flask-Migrate

# Créer un fichier api.py avec le code de base pour une application Flask simple
echo "from flask import Flask\n" > api.py
echo "app = Flask(__name__)\n" >> api.py
echo "@app.route('/')\n" >> api.py
echo "def hello_world():\n" >> api.py
echo "    return 'Hello, World!'\n" >> api.py
echo "if __name__ == '__main__':\n" >> api.py
echo "    app.run(debug=True)" >> api.py

# Sortir du programme
deactivate

# Terminer le script
exit
