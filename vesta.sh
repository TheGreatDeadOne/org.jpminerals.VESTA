#!/bin/sh
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
VESTA_CONFIG="$CONFIG_DIR/VESTA"

mkdir -p "$VESTA_CONFIG"

if [ ! -e "$HOME/.VESTA" ]; then
    ln -s "$VESTA_CONFIG" "$HOME/.VESTA"
fi

# Remove arquivos temporários de IPC e travas residuais de execuções anteriores
rm -f "$HOME/.VESTA"/vesta_*
rm -f "$HOME/.VESTA"/*.pid

cd /app/lib/VESTA
exec ./VESTA "$@"
