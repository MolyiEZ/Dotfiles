#!/usr/bin/env bash
set -euo pipefail
trap 'echo -e "\n[x] Error on line $LINENO: $BASH_COMMAND" >&2' ERR

REPO_URL="https://github.com/MolyiEZ/Dotfiles"

# Helpers
have_cmd() { command -v "$1" >/dev/null 2>&1; }
say() { printf "\033[1;32m[*]\033[0m %s\n" "$*"; }

# Check root
if [[ $EUID -ne 0 ]]; then
    sudo -v || { echo "Need sudo to continue."; exit 1; }
fi

# Refresh mirrors & system
sudo pacman -Syyu --needed --noconfirm archlinux-keyring

# Essentials
sudo pacman -S --needed --noconfirm base-devel git curl wget rsync unzip tar xz xdg-user-dirs fbset

# Uninstalling old apps
sudo pacman -Rns kitty dolphin # Hyprland
sudo pacman -Rns alacritty swaylock # Niri or Sway

# yay (AUR helper)
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

# Packages (pacman + Flatpak + AUR via yay)
AURPKGS=(
    zsh-theme-powerlevel10k-git
    aseprite
    papirus-folders
    awatcher-bundle-bin
    swaylock-effects
    zen-browser-bin
)

FLATPAKS=(
    org.gnome.Calculator
    org.vinegarhq.Vinegar
    org.vinegarhq.Sober
    com.stremio.Stremio
)

PKGS=(
    # Core CLI
    7zip eza fd fzf ripgrep yq tmux nvim yazi git npm unrar gvfs
    # Shell + zsh
    zsh zsh-syntax-highlighting
    # Fonts / spelling
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd otf-codenewroman-nerd vim-spell-en vim-spell-es

    # Wayland apps / theming
    foot fuzzel waybar nwg-look
    # Media
    vlc vlc-plugins-all
    # Others
    wl-clipboard
    gimp
    xournalpp
    cargo
    thunar tumbler baobab pavucontrol
    discord steam gamemode

    # - SELECT ONE -

    # Hyprland
    # hyprland hypridle hyprlock hyprpaper hyprshot meson cpio

    # Niri
    # swww xwayland-satellite

    # Sway
    # swww
)

say "Installing packages via pacman..."
sudo pacman -S --needed --noconfirm "${PKGS[@]}"

say "Installing packages via yay (AUR)..."
if ((${#AURPKGS[@]})); then
    yay -S --needed --noconfirm "${AURPKGS[@]}"
fi

# Check for flatpak
if ! have_cmd flatpak; then
    sudo pacman -S --needed --noconfirm flatpak
fi

say "Installing Flatpaks..."
for app in "${FLATPAKS[@]}"; do
    flatpak install -y flathub "$app" || true
done

say "Installing rojo via cargo..."
cargo install rojo --version ^7

# Remove ~/.config and clone everything onto $HOME
say "Removing ~/.config ..."
rm -rf "$HOME/.config"

say "Cloning repo and laying files into \$HOME ..."
TMP_CLONE="$(mktemp -d)"
git clone --depth=1 "$REPO_URL" "$TMP_CLONE"

# Copy repo contents into $HOME
rsync -a \
    --exclude "README.md" --exclude "installer.zsh" \
    "$TMP_CLONE"/ "$HOME"/

rm -rf "$TMP_CLONE"

# Tmux plugin manager
say "Installing tmux plugin manager..."
git clone "https://github.com/tmux-plugins/tpm" "~/.config/tmux/plugins/tpm"
say "Tmux plugin manager installed, please use 'prefix+I' when using tmux for the first time to install the plugins."

# Default shell -> zsh
if [[ "${SHELL:-}" != *zsh ]]; then
    chsh -s "$(command -v zsh)" "$USER" || true
fi

# Papirus dark folders
papirus-folders -C black --theme Papirus-Dark

# ASK TO REBOOT
read -r -p "Everything done. Reboot now? [Y/n] " ans
case "${ans:-N}" in
    n|N)   say "Done. You can reboot later." ;;
    *) systemctl reboot ;;
esac
