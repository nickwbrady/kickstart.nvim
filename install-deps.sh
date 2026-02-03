#!/bin/bash
# Install dependencies for this Neovim configuration
# Run: bash install-deps.sh

set -e

echo "=== Neovim Config Dependencies Installer ==="

# Check for required system tools
MISSING=""
for cmd in git make unzip gcc curl; do
  if ! command -v $cmd &> /dev/null; then
    MISSING="$MISSING $cmd"
  fi
done

if [ -n "$MISSING" ]; then
  echo "Missing required system tools:$MISSING"
  echo "Install with: sudo apt install$MISSING"
  exit 1
fi

# Check for ripgrep (rg)
if ! command -v rg &> /dev/null; then
  echo "Warning: ripgrep (rg) not found. Install with: sudo apt install ripgrep"
fi

# Install tree-sitter-cli (required for nvim-treesitter parser compilation)
if ! command -v tree-sitter &> /dev/null; then
  echo "Installing tree-sitter-cli..."

  if command -v npm &> /dev/null; then
    npm install -g tree-sitter-cli
  elif command -v cargo &> /dev/null; then
    cargo install tree-sitter-cli
  else
    echo "Error: Neither npm nor cargo found. Install one of:"
    echo "  - Node.js/npm: https://nodejs.org/"
    echo "  - Rust/cargo: https://rustup.rs/"
    exit 1
  fi

  echo "tree-sitter-cli installed successfully"
else
  echo "tree-sitter-cli already installed: $(tree-sitter --version)"
fi

echo ""
echo "=== Dependencies installed ==="
echo "You can now start Neovim. Treesitter parsers will be compiled on first launch."
