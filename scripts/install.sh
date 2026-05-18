#!/usr/bin/env bash
# gmajail — one-line installer
# curl -sL https://raw.githubusercontent.com/ob4cl/gmajail/main/scripts/install.sh | bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}"
cat << 'BANNER'
  __ _ _ __ ___   __ _ _  __ _ _| |
 / _` | '_ ` _ \ / _` | |/ _` | | |
| (_| | | | | | | (_| | | (_| | | |
 \__, |_| |_| |_|\__,_| |\__,_|_|_|
  __/ |              _/ |
 |___/              |__/
BANNER
echo -e "${NC}"
echo "gmajail installer — Gemma 4 web terminal"
echo ""

# Check Ollama
if ! command -v ollama &>/dev/null; then
    echo -e "${YELLOW}Ollama not found. Install it first: https://ollama.com${NC}"
    exit 1
fi

echo -e "→ ${GREEN}Ollama found${NC}"

# Check/pull model
if ! ollama list 2>/dev/null | grep -q "gemma-4-e2b"; then
    echo "→ Pulling gemma-4-e2b model..."
    ollama pull gemma-4-e2b
else
    echo -e "→ ${GREEN}Model already installed${NC}"
fi

# Install Python deps
echo "→ Installing Python dependencies..."
pip install -r backend/requirements.txt -q 2>/dev/null || pip install aiohttp -q

# Done
echo ""
echo -e "${GREEN}✓ gmajail installed${NC}"
echo ""
echo "  Start:  python3 backend/server.py"
echo "  Open:   http://localhost:8080"
echo ""
