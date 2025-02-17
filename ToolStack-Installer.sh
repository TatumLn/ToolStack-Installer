#!/bin/bash

# Afficher le titre stylisé
echo -e "\033[1;36m"  # Couleur cyan
figlet -f slant "ToolStack-Installer"
echo -e "\033[0m"     # Réinitialiser la couleur

# Message de bienvenue
echo -e "\n\033[1;32mBienvenue dans ToolStack-Installer !\033[0m"
echo -e "Ce script vous permet d'installer rapidement les outils essentiels pour le développement et DevOps.\n"

# Fonction pour détecter et afficher la distribution Linux
detect_distribution() {
    if [ -f /etc/os-release ]; then
        # Récupération de l'ID de la distribution depuis os-release
        . /etc/os-release
        DISTRO=$ID
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/redhat-release ]; then
        if grep -q "CentOS" /etc/redhat-release; then
            DISTRO="centos"
        else
            DISTRO="rhel"
        fi
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
    else
        DISTRO="unknown"
    fi
    echo $DISTRO
}

# Fonction pour vérifier l'installation d'un paquetage
is_package_installed() {
    local package=$1
    if [ "$distro" == "debian" ] || [ "$distro" == "ubuntu" ] || [ "$distro" == "linuxmint" ] || [ "$distro" == "kali" ]; then
        dpkg -s $package &> /dev/null
    elif [ "$distro" == "centos" ] || [ "$distro" == "rhel" ]  || [ "$distro" == "fedora" ]; then
        rpm -q $package &> /dev/null
    fi
}

# Fonction pour installer un paquetage selon la distribution
install_package() {
    local package=$1
    local distro=$(detect_distribution)

    if is_package_installed "$package"; then
        echo "L'éditeur $package est déjà installé."
        return 0
    else
    	if [ "$distro" == "debian" ] || [ "$distro" == "ubuntu" ] || [ "$distro" == "linuxmint" ] || [ "$distro" == "kali" ]; then
        	sudo apt update
       		# sudo apt install $package -y
    	elif [ "$distro" == "centos" ] || [ "$distro" == "rhel" ] || [ "$distro" == "fedora" ]; then
		sudo dnf update
       		# sudo dnf install $package -y
    	elif [ "$distro" == "arch" ]; then
		sudo pacman -Sy
		#sudo pacman -S
    	else
        	echo "Distribution inconnue"
	fi
    fi
}

# Détection de la distribution
DISTRO=$(detect_distribution)
echo -e "\033[1;36mDistribution détectée: $DISTRO\033[0m\n"

# Liste des IDEs disponibles
IDEs=("Visual Studio Code" "IntelliJ IDEA" "PyCharm" "Sublime Text" "Vim" "Quitter")

# Afficher le menu
echo -e "\033[1;33mSélectionnez l'IDE que vous souhaitez installer :\033[0m"

select ide in "${IDEs[@]}"; do
    case $ide in
        "Visual Studio Code")
            echo -e "\nVous avez sélectionné : \033[1;34mVisual Studio Code\033[0m"
            # Installation pour VS Code
	    install_package jenkins
            break
            ;;
        "IntelliJ IDEA")
            echo -e "\nVous avez sélectionné : \033[1;34mIntelliJ IDEA\033[0m"
            # Installation pour IntelliJ IDEA
	    install_package
            break
            ;;
        "PyCharm")
            echo -e "\nVous avez sélectionné : \033[1;34mPyCharm\033[0m"
            # Installation pour PyCharm
	    install_package
            break
            ;;
        "Sublime Text")
            echo -e "\nVous avez sélectionné : \033[1;34mSublime Text\033[0m"
            # Installation pour Sublime Text
	    install_package
            break
            ;;
        "Vim")
            echo -e "\nVous avez sélectionné : \033[1;34mVim\033[0m"
            # Installation pour Vim
	    install_package
            break
            ;;
        "Quitter")
            echo -e "\n\033[1;31mInstallation annulée. À bientôt !\033[0m"
            exit 0
            ;;
        *)
            echo -e "\n\033[1;31mOption invalide. Veuillez choisir un numéro valide.\033[0m"
            ;;
    esac
done
