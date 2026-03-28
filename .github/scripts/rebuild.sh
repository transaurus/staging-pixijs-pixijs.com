#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for pixijs/pixijs.com
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version: 24 via nvm ---
export NVM_DIR="${HOME:-/root}/.nvm"
if [ ! -f "$NVM_DIR/nvm.sh" ]; then
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
# shellcheck source=/dev/null
. "$NVM_DIR/nvm.sh"

nvm install 24
nvm use 24

export PATH="$NVM_DIR/versions/node/$(node --version)/bin:$PATH"

echo "[INFO] Node: $(node --version)"
echo "[INFO] npm: $(npm --version)"

# --- Dependencies ---
npm install

# --- Pre-build step: generate content (required so Docusaurus can load config properly) ---
npm run generate || echo "[WARNING] generate step had errors, continuing..."

# --- Build ---
npm run build

echo "[DONE] Build complete."
