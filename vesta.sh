#!/bin/sh
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
VESTA_CONFIG="$CONFIG_DIR/VESTA"

mkdir -p "$VESTA_CONFIG"

if [ ! -e "$HOME/.VESTA" ]; then
    ln -sf "$VESTA_CONFIG" "$HOME/.VESTA"
fi

exec /app/lib/VESTA/VESTA "$@"
