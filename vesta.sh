#!/bin/sh

set -eu

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
VESTA_DIR="$CONFIG_DIR/VESTA"

mkdir -p "$VESTA_DIR"

TEMP_HOME="${XDG_RUNTIME_DIR:-/tmp}/vesta-home-$$"

mkdir -p "$TEMP_HOME"

cleanup() {
    rm -rf "$TEMP_HOME"
}

trap cleanup EXIT INT TERM

ln -s "$VESTA_DIR" "$TEMP_HOME/.VESTA"

export HOME="$TEMP_HOME"

cd /app/lib/VESTA
exec ./VESTA "$@"
