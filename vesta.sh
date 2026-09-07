#!/bin/sh

export PATH="/app/jre/bin:$PATH"
export JAVA_HOME="/app/jre"
export LD_LIBRARY_PATH="/app/lib/VESTA:/app/lib/VESTA/PowderPlot${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export GDK_BACKEND=x11

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$CONFIG_DIR"

if [ -e "$HOME/.VESTA" ] && [ ! -L "$HOME/.VESTA" ]; then
    mv "$HOME/.VESTA" "$CONFIG_DIR/.VESTA"
fi

rm -f "$HOME/.VESTA"
ln -sf "$CONFIG_DIR/.VESTA" "$HOME/.VESTA"

cd /app/lib/VESTA
exec ./VESTA "$@"
