#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

echo "==> Installing dependencies..."
sudo pacman -S --needed --noconfirm stow git

if [ ! -d "$DOTFILES" ]; then
    echo "==> Cloning dotfiles..."
    git clone git@github.com:Singdile/.dotfiles.git "$DOTFILES"
fi

cd "$DOTFILES"

echo "==> Stowing packages..."
PACKAGES=(hypr waybar zsh bash git rofi fcitx5 emacs)
for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "  -> stow $pkg"
        stow -t "$HOME" "$pkg"
    fi
done

echo "==> Tangling Hyprland config from org..."
if command -v emacs &>/dev/null; then
    emacs -nw --batch --eval "
(progn
  (find-file \"$HOME/.config/hypr/config.org\")
  (org-babel-tangle)
  (kill-emacs 0))
" 2>/dev/null && echo "  -> hyprland config tangled successfully" || echo "  -> warning: org-babel-tangle failed, run manually"
else
    echo "  -> warning: emacs not found, install it and tangle hypr config.org manually"
fi

echo ""
echo "==> Done! Log out and back in for shell changes, or run:"
echo "    source ~/.zshrc"
echo "    source ~/.bashrc"
