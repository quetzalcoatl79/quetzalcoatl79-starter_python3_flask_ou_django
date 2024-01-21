#!/bin/bash

open_and_close(){
    # Ouvrir l'explorateur de fichiers avec le répertoire du projet
    if [ "$(uname)" == "Linux" ] || [ "$(uname)" == "Darwin" ]; then
        xdg-open "$1"
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        explorer.exe "$1"
    fi    
}



echo "Vérification du système d'exploitation..."

# Vérifier le système d'exploitation
if [ "$(uname)" == "Linux" ]; then
    echo "Système d'exploitation Linux détecté."
    # Vérifier la présence de Python
    if command -v python3 &>/dev/null; then
        echo "Python est déjà installé."
    else
        # Installer Python sur Linux
        echo "Python n'est pas installé. Installation en cours..."
        sudo apt-get update
        sudo apt-get install -y python3
    fi
elif [ "$(uname)" == "Darwin" ]; then
    echo "Système d'exploitation macOS détecté."
    # Vérifier la présence de Python
    if command -v python3 &>/dev/null; then
        echo "Python est déjà installé."
    else
        # Installer Python sur macOS
        echo "Python n'est pas installé. Installation en cours..."
        # Ajoutez ici la logique pour installer Python sur macOS
    fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Système d'exploitation Windows détecté."
    # Vérifier la présence de Python
    if command -v python &>/dev/null; then
        echo "Python est déjà installé."
    else
        # Installer Python sur Windows
        echo "Python n'est pas installé. Installation en cours..."
        # Ajoutez ici la logique pour installer Python sur Windows
    fi
else
    echo "Système d'exploitation non pris en charge."
    exit 1
fi

# Demander le nom du projet
read -p "Entrez le nom du projet: " project_name


# DEMANDE SI BDD
# Demander si l'utilisateur souhaite installer une base de données
read -p "Voulez-vous installer une base de données? (y/n): " install_db

if [ "$install_db" == "y" ]; then
    # Afficher les options de bases de données disponibles
    echo "Choisissez la base de données à installer:"
    echo "1. MariaDB"
    echo "2. SQLite"
    echo "3. PostgreSQL"
    echo "4. MongoDB"
    
    # Demander à l'utilisateur de faire un choix
    read -p "Entrez le numéro correspondant à la base de données souhaitée: " db_choice
    chmod +x bdd/install_bdd.sh
    case $db_choice in
        1)
            # Installer MariaDB
            echo "Installation de MariaDB..."
            ./bdd/install_bdd.sh MariaDB
            ;;
        2)
            # Installer SQLite
            echo "Installation de SQLite..."
            ./bdd/install_bdd.sh "SQLite"
            ;;
        3)
            # Installer PostgreSQL
            echo "Installation de PostgreSQL..."
            ./bdd/install_bdd.sh "PostgreSQL"
            ;;
        4)
            # Installer MongoDB
            echo "Installation de MongoDB..."
            ./bdd/install_bdd.sh "MongoDB"
            ;;
        *)
            echo "Choix non valide."
            ;;
    esac
fi

# ...


# Vérifier le système d'exploitation pour la création du dossier
if [ "$(uname)" == "Linux" ] || [ "$(uname)" == "Darwin" ]; then
    project_folder=~/Documents/"$project_name"
    mkdir -p "$project_folder"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    project_folder=~/Documents/"$project_name"
    mkdir -p "$project_folder"
else
    echo "Système d'exploitation non pris en charge."
    exit 1
fi

# Vérifier que le répertoire du projet a été créé
if [ ! -d "$project_folder" ]; then
    echo "Erreur: Le répertoire du projet n'a pas pu être créé."
    exit 1
fi

# Créer une venv dans le dossier du projet
if [ "$(uname)" == "MINGW32_NT" ]; then
    python -m venv "$project_folder"/venv
else
    python3 -m venv "$project_folder"/venv
fi

# Activer l'environnement virtuel (compatible avec Windows, macOS, et Linux)
source "$project_folder"/venv/bin/activate || source "$project_folder"/venv/Scripts/activate

# Demander si l'utilisateur veut installer Django
read -p "Voulez-vous installer Django? (y/n): " install_django


if [ "$install_django" == "y" ]; then
    # Appeler le script d'installation de Django directement
    chmod +x ./librairies/install_django.sh
    ./librairies/install_django.sh "$project_folder" "$project_name"
    # ou bash ./librairies/install_django.sh "$project_folder"
    open_and_close "$project_folder"
    # Lancer le serveur de développement
    echo "flask installer"
    read -p "Voulez-vous lancer Django? (y/n): " run_django
    if [ "$run_django" == "y" ]; then
        python manage.py runserver
        # Sortir du programme
        deactivate || deactivate.bat
    else 
        # Sortir du programme
        deactivate || deactivate.bat
        exit    
    

else
    # Si l'utilisateur ne veut pas installer Django, demander s'il veut installer Flask
    read -p "Voulez-vous installer Flask? (y/n): " install_flask
    if [ "$install_flask" == "y" ]; then
        # Installer Flask dans l'environnement virtuel
        chmod +x ./librairies/install_flask.sh
        ./librairies/install_flask.sh "$project_folder" "$project_name"
        open_and_close "$project_folder"
        # Sortir du programme
        deactivate || deactivate.bat
        echo "flask installer"
    else
        exit    
    fi
fi


j'aimerai que mon script me demande si je souhaite installer une bdd ici : # DEMANDE SI BDD et souhaite qu'il me propse 1 mariadb 2 sqlite 3 postgres 4 mongodb 
je souhaites d'une installe se lance si je tape 1 par exemple le programme m'installe mariadb ... attention prend en consideration l'OS et egalement si je tape 2 
je veux que toute les lib s'installe dans project_folder 