#!/bin/sh
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
VESTA_CONFIG="$CONFIG_DIR/VESTA"
mkdir -p "$VESTA_CONFIG"
if [ ! -e "$HOME/.VESTA" ]; then
    ln -sf "$VESTA_CONFIG" "$HOME/.VESTA"
fi

for pidfile in "$HOME/.VESTA"/*.pid; do
    [ -e "$pidfile" ] || continue
    pid=$(cat "$pidfile" 2>/dev/null)
    if [ -z "$pid" ] || ! kill -0 "$pid" 2>/dev/null; then
        rm -f "$pidfile"
    fi
done

cd /app/lib/VESTA
exec ./VESTA "$@"
