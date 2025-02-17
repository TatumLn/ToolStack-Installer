#!/bin/bash

# Afficher le titre stylisé
echo -e "\033[1;36m"  # Couleur cyan
figlet -f slant "ToolStack-Installer"
echo -e "\033[0m"     # Réinitialiser la couleur

# Message de bienvenue
echo -e "\n\033[1;32mBienvenue dans ToolStack-Installer !\033[0m"
echo -e "Ce script vous permet d'installer rapidement les outils essentiels pour le développement et DevOps.\n"

# Liste des IDEs disponibles
IDEs=("Visual Studio Code" "IntelliJ IDEA" "PyCharm" "Sublime Text" "Vim" "Quitter")

# Afficher le menu
echo -e "\033[1;33mSélectionnez l'IDE que vous souhaitez installer :\033[0m"

select ide in "${IDEs[@]}"; do
    case $ide in
        "Visual Studio Code")
            echo -e "\nVous avez sélectionné : \033[1;34mVisual Studio Code\033[0m"
            # Ajouter ici la commande d'installation pour VS Code
            break
            ;;
        "IntelliJ IDEA")
            echo -e "\nVous avez sélectionné : \033[1;34mIntelliJ IDEA\033[0m"
            # Ajouter ici la commande d'installation pour IntelliJ IDEA
            break
            ;;
        "PyCharm")
            echo -e "\nVous avez sélectionné : \033[1;34mPyCharm\033[0m"
            # Ajouter ici la commande d'installation pour PyCharm
            break
            ;;
        "Sublime Text")
            echo -e "\nVous avez sélectionné : \033[1;34mSublime Text\033[0m"
            # Ajouter ici la commande d'installation pour Sublime Text
            break
            ;;
        "Vim")
            echo -e "\nVous avez sélectionné : \033[1;34mVim\033[0m"
            # Ajouter ici la commande d'installation pour Vim
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
