#!/bin/sh
export PATH="/app/jre/bin:$PATH"
export JAVA_HOME="/app/jre"
export LD_LIBRARY_PATH="/app/lib/VESTA:/app/lib/VESTA/PowderPlot:$LD_LIBRARY_PATH"
export GDK_BACKEND=x11

# Cria o diretório de configuração do Flatpak e redireciona o .VESTA do usuário
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$CONFIG_DIR"

# Garante que a pasta esperada pelo VESTA aponte para o local correto dentro da sandbox
rm -rf "$HOME/.VESTA"
ln -sf "$CONFIG_DIR" "$HOME/.VESTA"

cd /app/lib/VESTA
exec ./VESTA "$@"
