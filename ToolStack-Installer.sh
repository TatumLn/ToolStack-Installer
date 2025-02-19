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
       		sudo apt install $package -y
    	elif [ "$distro" == "centos" ] || [ "$distro" == "rhel" ] || [ "$distro" == "fedora" ]; then
		sudo dnf install $package -y
		#sudo yum install $package -y
    	elif [ "$distro" == "arch" ]; then
		sudo pacman -Sy $package --noconfirm
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
echo -e "\033[1;33mSélectionnez l'Éditeurs de Code / IDE que vous souhaitez installer :\033[0m"

select ide in "${IDEs[@]}"; do
    case $ide in
        "Visual Studio Code")
            echo -e "\nVous avez sélectionné : \033[1;34mVisual Studio Code\033[0m"

	    distro=$(detect_distribution)

            case $distro in
            	"debian" | "ubuntu" | "linuxmint" | "kali")
                    echo -e "\033[1;36mInstallation de Visual Studio Code pour Debian/Ubuntu...\033[0m"
            	    sudo apt-get install wget gpg
            	    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
            	    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
            	    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
            	    rm -f packages.microsoft.gpg
            	    sudo apt install apt-transport-https
            	    sudo apt update
	    	    sudo apt install code -y
                    ;;
                "centos" | "rhel" | "fedora")
                    echo -e "\033[1;36mInstallation de Visual Studio Code pour CentOS/RHEL/Fedora...\033[0m"
	    	    sudo sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            	    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
            	    dnf check-update
		    sudo dnf install code -y
                    ;;
                "arch")
                    echo -e "\033[1;36mInstallation de Visual Studio Code pour Arch Linux...\033[0m"
	   	    sudo pacman -Sy code --noconfirm
                    ;;
		                *)
                    echo -e "\033[1;31mDistribution non supportée : $distro\033[0m"
                    ;;
            esac
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
	    install_package vim
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
