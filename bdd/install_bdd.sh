#!/bin/bash

install_bdd="$1"-y 

install_mariadb_linux() {
    echo "Installation de MariaDB sur Linux..."
    sudo apt-get update && sudo apt-get install -y mariadb-server libmariadbclient-dev
}

install_mariadb_macos() {
    echo "Installation de MariaDB sur macOS..."
    brew install mariadb
}

install_mariadb_windows() {
    echo "Téléchargez et installez MariaDB depuis https://downloads.mariadb.org/mariadb/"
    echo "Assurez-vous de suivre les instructions d'installation fournies sur le site officiel."
}

install_sqlite_linux() {
    echo "Installation de SQLite sur Linux..."
    sudo apt-get update && sudo apt-get install -y sqlite3 libsqlite3-dev
}

install_sqlite_macos() {
    echo "SQLite est déjà inclus sur macOS. Aucune installation nécessaire."
}

install_sqlite_windows() {
    echo "Téléchargez et installez SQLite depuis https://www.sqlite.org/download.html"
    echo "Assurez-vous de suivre les instructions d'installation fournies sur le site officiel."
}

install_postgresql_linux() {
    echo "Installation de PostgreSQL sur Linux..."
    sudo apt-get update && sudo apt-get install -y postgresql postgresql-contrib libpq-dev
}

install_postgresql_macos() {
    echo "Installation de PostgreSQL sur macOS..."
    brew install postgresql
}

install_postgresql_windows() {
    echo "Téléchargez et installez PostgreSQL depuis https://www.postgresql.org/download/"
    echo "Assurez-vous de suivre les instructions d'installation fournies sur le site officiel."
}

install_mongodb_linux() {
    echo "Installation de MongoDB sur Linux..."
    sudo apt-get update && sudo apt-get install -y mongodb
}

install_mongodb_macos() {
    echo "Installation de MongoDB sur macOS..."
    brew install mongodb
}

install_mongodb_windows() {
    echo "Téléchargez et installez MongoDB depuis https://www.mongodb.com/try/download/community"
    echo "Assurez-vous de suivre les instructions d'installation fournies sur le site officiel."
}

# Vérification de l'installation de MariaDB
if [ "$install_bdd" == "MariaDB" ]; then
    # Vérification du système d'exploitation
    if [ "$(uname)" == "Linux" ]; then
        install_mariadb_linux || { echo "Échec de l'installation de MariaDB sur Linux."; exit 1; }
    elif [ "$(uname)" == "Darwin" ]; then
        install_mariadb_macos || { echo "Échec de l'installation de MariaDB sur MACOS."; exit 1; }
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        install_mariadb_windows || { echo "Échec de l'installation de MariaDB sur Windows."; exit 1; }
    else
        echo "Système d'exploitation non pris en charge."
        exit 1
    fi
fi

# Vérification de l'installation de SQLite
if [ "$install_bdd" == "SQLite" ]; then
    # Vérification du système d'exploitation
    if [ "$(uname)" == "Linux" ]; then
        install_sqlite_linux || { echo "Échec de l'installation de SQLite sur Linux."; exit 1; }
    elif [ "$(uname)" == "Darwin" ]; then
        install_sqlite_macos
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        install_sqlite_windows || { echo "Échec de l'installation de SQLite sur MACOS."; exit 1; }
    else
        echo "Système d'exploitation non pris en charge."
        exit 1
    fi
fi

# Vérification de l'installation de PostgreSQL
if [ "$install_bdd" == "PostgreSQL" ]; then
    # Vérification du système d'exploitation
    if [ "$(uname)" == "Linux" ]; then
        install_postgresql_linux || { echo "Échec de l'installation de PostgreSQL sur Linux."; exit 1; }
    elif [ "$(uname)" == "Darwin" ]; then
        install_postgresql_macos || { echo "Échec de l'installation de PostgreSQL sur MACOS."; exit 1; }
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        install_postgresql_windows || { echo "Échec de l'installation de PostgreSQL sur Windows."; exit 1; }
    else
        echo "Système d'exploitation non pris en charge."
        exit 1
    fi
fi

# Vérification de l'installation de MongoDB
if [ "$install_bdd" == "MongoDB" ]; then
    # Vérification du système d'exploitation
    if [ "$(uname)" == "Linux" ]; then
        install_mongodb_linux || { echo "Échec de l'installation de MongoDB sur Linux."; exit 1; }
    elif [ "$(uname)" == "Darwin" ]; then
        install_mongodb_macos || { echo "Échec de l'installation de MongoDB sur MACOS."; exit 1; }
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        install_mongodb_windows || { echo "Échec de l'installation de MongoDB sur Windows."; exit 1; }
    else
        echo "Système d'exploitation non pris en charge."
        exit 1
    fi
fi
