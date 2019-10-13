#!/usr/bin/env bash
set -e

echo "🚧🚧🚧  WARNING: This will completely delete ALL Vim-related files  🚧🚧🚧"
echo " - What is your user account's 'home' name? (e.g., /home/?/...)"
read -e HOME_NAME

# ===========================================
# Uninstalling Vim
# ===========================================

# TODO: Generalize the uninstallation call to popular package managers. Create Windows and MacOS compatibility.


echo "[-] Removing ~/.vim..."
sudo rm -rf /home/$HOME_NAME/.vim
echo "[-] Removing ~/.vim_runtime..."
sudo rm -rf /home/$HOME_NAME/.vim_runtime
echo "[-] Deleting .vimrc..."
sudo rm -rf /home/$HOME_NAME/.vimrc
echo "[-] Deleting .viminfo..."
sudo rm -rf /home/$HOME_NAME/.viminfo
echo "[-] Deleting .vim_mru_files..."
sudo rm -rf /home/$HOME_NAME/.vim_mru_files
echo ''
echo "[-] Deleting .vim-rfc.yml..."
sudo rm -rf /home/$HOME_NAME/.vim-rfc.yml
echo ''

echo "Removing Language Support"
echo "[-] Deleting golang..."
sudo pacman -Rns golang
echo "[-] Deleting mono..."
sudo pacman -Rns mono


echo "[-] Deleting RustUp..."
rustup self uninstall

echo "[-] Removing NerdFonts"
sudo rm -rf /home/$HOME_NAME/.local/share/fonts/NerdFonts
echo ''

echo "[-] Uninstalling vim..."
sudo pacman -Rns vim gvim neovim neovim-qt
echo ''

echo "Vim uninstalled successfully."
echo ''
