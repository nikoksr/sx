#!/usr/bin/env bash

set -euo pipefail

SOURCE_REPO="nikoksr/sx"
SOURCE_BRANCH="main"
SOURCE_FILE="sx"

INSTALL_DIR=""

# ── Argument Parsing ─────────────────────────────────────────────

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir)
      [[ $# -lt 2 ]] && {
        echo "Error: --dir requires a value" >&2
        exit 1
      }
      INSTALL_DIR="$2"
      shift 2
      ;;
    -h | --help)
      echo "Usage: $0 [--dir INSTALL_DIR]"
      echo ""
      echo "Install sx - Universal Search Tool"
      echo ""
      echo "Options:"
      echo "  --dir DIR  Install to DIR (default: ~/.local/bin)"
      exit 0
      ;;
    *)
      echo "Error: unknown option '$1'" >&2
      exit 1
      ;;
  esac
done

# ── Install ──────────────────────────────────────────────────────

# Default install directory: XDG_BIN_HOME > ~/.local/bin
[[ -z "$INSTALL_DIR" ]] && INSTALL_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"

mkdir -p "$INSTALL_DIR"
TARGET="$INSTALL_DIR/$SOURCE_FILE"

# Detect source: local (cloned repo) vs remote (curl | bash)
script_dir="$(cd "$(dirname "$0")" && pwd)"
if [[ -f "$script_dir/$SOURCE_FILE" ]] && [[ -f "$script_dir/install.sh" ]]; then
  echo "Installing from local copy..."
  cp "$script_dir/$SOURCE_FILE" "$TARGET"
else
  echo "Downloading $SOURCE_FILE..."
  curl -fsSL "https://raw.githubusercontent.com/$SOURCE_REPO/$SOURCE_BRANCH/$SOURCE_FILE" -o "$TARGET"
fi

chmod +x "$TARGET"

echo ""
echo "✓ Installed $SOURCE_FILE to $TARGET"

# PATH check
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "Warning: $INSTALL_DIR is not in your PATH."
  echo "Add it with: export PATH=\"$INSTALL_DIR:\$PATH\""
fi

# Dependency check (warn only; sx does a hard check at runtime)
missing=()
for cmd in fd rg fzf bat; do
  case "$cmd" in
    fd) command -v fd > /dev/null 2>&1 || command -v fdfind > /dev/null 2>&1 || missing+=("fd") ;;
    bat) command -v bat > /dev/null 2>&1 || command -v batcat > /dev/null 2>&1 || missing+=("bat") ;;
    *) command -v "$cmd" > /dev/null 2>&1 || missing+=("$cmd") ;;
  esac
done

if [[ ${#missing[@]} -gt 0 ]]; then
  echo ""
  echo "Note: missing dependencies: ${missing[*]}"
  echo "Install them before using sx. See https://github.com/$SOURCE_REPO#installation"
fi
