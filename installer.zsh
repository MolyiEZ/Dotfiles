#!/usr/bin/env bash
set -euo pipefail
trap 'echo -e "\n[x] Error on line $LINENO: $BASH_COMMAND" >&2' ERR

REPO_URL="https://github.com/MolyiEZ/Dotfiles"

# ---------------------------
# Helpers
# ---------------------------
need_root() {
  if [[ $EUID -ne 0 ]]; then
    sudo -v || { echo "Need sudo to continue."; exit 1; }
  fi
}
have_cmd() { command -v "$1" >/dev/null 2>&1; }
say() { printf "\033[1;32m[*]\033[0m %s\n" "$*"; }

# ---------------------------
# Preconditions
# ---------------------------
[[ -f /etc/arch-release ]] || { echo "This script is for Arch Linux."; exit 1; }
need_root

# Refresh mirrors & system
sudo sed -i 's/^#\?ParallelDownloads = .*/ParallelDownloads = 10/' /etc/pacman.conf || true
sudo pacman -Sy --needed --noconfirm archlinux-keyring
sudo pacman -Syyu --needed --noconfirm

# Essentials
sudo pacman -S --needed --noconfirm base-devel git curl wget rsync unzip tar xz xdg-user-dirs

# Uninstalling old apps
sudo pacman -Rns kitty dolphin

# ---------------------------
# yay (AUR helper)
# ---------------------------
if ! have_cmd yay; then
  say "Installing yay (AUR helper)…"
  tmpdir="$(mktemp -d)"
  pushd "$tmpdir" >/dev/null
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  popd >/dev/null
  rm -rf "$tmpdir"
fi

# ---------------------------
# Packages (pacman + AUR via yay)
# ---------------------------
AURPKGS=(
  # zsh theme
  zsh-theme-powerlevel10k-git
  aseprite
  stremio
  papirus-folders
  awatcher-bundle-bin
  zen-browser-bin
)

PKGS=(
  # Core CLI
  7zip eza fd fzf ripgrep yq tmux nvim yazi git npm unrar
  # Shell + zsh
  zsh zsh-syntax-highlighting
  # Fonts / spelling
  ttf-jetbrains-mono ttf-jetbrains-mono-nerd otf-codenewroman-nerd vim-spell-en vim-spell-es
  # Hyprland ecosystem
  hyprland hypridle hyprlock hyprpaper hyprpicker hyprshot
  # Wayland apps / theming
  foot wofi waybar nwg-look
  # Media
  vlc vlc-plugins-all
  # Others
  gimp
  thunar tumbler baobab pavucontrol
  cargo discord
  steam
)

say "Installing packages via pacman…"
sudo pacman -S --needed --noconfirm "${PKGS[@]}"

say "Installing packages via yay (AUR)…"
if ((${#AURPKGS[@]})); then
  yay -S --needed --noconfirm "${AURPKGS[@]}"
fi

say "Installing rojo via cargo..."
cargo install rojo --version ^7

# ---------------------------
# Flatpak & apps
# ---------------------------
if ! have_cmd flatpak; then
  sudo pacman -S --needed --noconfirm flatpak
fi

FLATPAKS=(
  org.gnome.Calculator
  org.vinegarhq.Vinegar
  org.vinegarhq.Sober
)

say "Installing Flatpaks…"
for app in "${FLATPAKS[@]}"; do
  flatpak install -y flathub "$app" || true
done

# ---------------------------
# Remove ~/.config and clone everything onto $HOME
# ---------------------------
say "Removing ~/.config …"
rm -rf "$HOME/.config"

say "Cloning repo and laying files into \$HOME …"
TMP_CLONE="$(mktemp -d)"
git clone --depth=1 "$REPO_URL" "$TMP_CLONE"

# Copy repo contents into $HOME
rsync -a \
  --exclude "README.md" --exclude "installer.zsh" \
  "$TMP_CLONE"/ "$HOME"/

rm -rf "$TMP_CLONE"

# Ensure XDG user dirs exist
xdg-user-dirs-update || true

# ---------------------------
# Default shell → zsh
# ---------------------------
if [[ "${SHELL:-}" != *zsh ]]; then
  chsh -s "$(command -v zsh)" "$USER" || true
fi

# Papirus dark folders
papirus-folders -C black --theme Papirus-Dark

# ---------------------------
# RELOAD HYPRLAND
# ---------------------------
if have_cmd hyprctl && pgrep -x Hyprland >/dev/null 2>&1; then
  say "Reloading Hyprland…"
  hyprctl reload || true
fi

# ---------------------------
# ASK TO REBOOT
# ---------------------------
read -r -p "Everything done. Reboot now? [y/N] " ans
case "${ans:-N}" in
  y|Y) systemctl reboot ;;
  *)   say "Done. You can reboot later." ;;
esac

