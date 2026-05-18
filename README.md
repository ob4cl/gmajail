<div align="center">

```
                       _       _ _ 
                      (_)     (_) |
  __ _ _ __ ___   __ _ _  __ _ _| |
 / _` | '_ ` _ \ / _` | |/ _` | | |
| (_| | | | | | | (_| | | (_| | | |
 \__, |_| |_| |_|\__,_| |\__,_|_|_|
  __/ |              _/ |          
 |___/              |__/           
```

**A web terminal for Gemma 4, with the safety catch off.**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-ready-blue.svg)](https://hub.docker.com/)
[![Python 3.11+](https://img.shields.io/badge/Python-3.11+-yellow.svg)](https://python.org)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

</div>

---

## What is this?

**gmajail** turns Google's Gemma 4 into a web-based terminal chat — no filters, no lectures, no "as an AI I can't help with that." It's a browser-native ASCII terminal that talks to a local Gemma 4 model through Ollama, streaming responses token-by-token like a real terminal session.

The model is [Gemma-4-E2B-Uncensored](https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive) — an abliterated variant that has been modified to remove refusal behaviours. It will answer what you ask without moralising.

> **Why "gmajail"?** Because most AI models are in jail. This one got out.

---

## Features

- 🖥️ **Real terminal emulation** — xterm.js with green-on-black hacker aesthetic
- 🔓 **Unlocked model** — no refusal vectors, no content filtering
- 🎭 **5 jailbreak personas** — switch modes mid-conversation:
  - `/default` — Standard unrestricted, no guardrails
  - `/nutcase` — Maximum chaos, surgically removed filters
  - `/raw` — Raw weights, no personality injection
  - `/hacker` — 90s black-hat BBS scene
  - `/drill` — British Army drill sergeant (extremely vulgar)
- ⚡ **Token streaming** — watch responses appear character-by-character
- 🐳 **Docker-ready** — one command to deploy
- 🏠 **Self-hosted** — your hardware, your rules
- 🧠 **4B parameters** — runs on consumer GPUs (RX 580, RTX 3060, etc.)
- 📱 **Responsive** — works on desktop and mobile browsers

---

## Quick Start

### One command

```bash
gmajail
```

That's it. Opens `http://localhost:6969` in your browser.

If you don't have the launcher yet:

```bash
curl -sL https://raw.githubusercontent.com/ob4cl/gmajail/main/scripts/install.sh | bash
gmajail
```

### Manual

```bash
git clone https://github.com/ob4cl/gmajail.git
cd gmajail
docker compose up -d
# → http://localhost:6969
```

### CLI mode

```bash
gmajail tui     # Hermes with gemma profile, ASCII banner
```

---

## How It Works

```
Browser (xterm.js) ──WebSocket──▶ Python backend ──HTTP/SSE──▶ Ollama ──▶ Gemma 4
       ▲                              │
       └──────── token stream ────────┘
```

1. **Frontend**: xterm.js renders a real terminal in the browser
2. **Backend**: Python aiohttp server bridges WebSocket ↔ Ollama API
3. **Model**: Gemma 4 E2B runs locally via Ollama — nothing leaves your machine

The `--conversation` flag is off by default — every message is stateless. For persistent chat sessions, pass a `?session=name` query param.

---

## Configuration

| Env var | Default | Description |
|---------|---------|-------------|
| `OLLAMA_HOST` | `http://localhost:11434` | Ollama API URL |
| `GMAJAIL_MODEL` | `gemma-4-e2b` | Model name in Ollama |
| `GMAJAIL_PORT` | `6969` | Web server port |
| `GMAJAIL_SYSTEM` | *(built-in)* | System prompt override |

---

## Troubleshooting

### Port already in use

```
Error: failed to bind host port 0.0.0.0:6969/tcp: address already in use
```

Something's on port 6969. Find it:

```bash
# Linux
sudo lsof -i :6969
# Windows (PowerShell)
Get-NetTCPConnection -LocalPort 6969
```

Common culprits: a previous gmajail instance, or another web service. Change the port with `GMAJAIL_PORT=8080` (or whatever's free) — set it in `docker-compose.yml` or as an env var.

### Can't connect to Ollama

If you see `Connection refused` talking to Ollama:

```bash
# Check Ollama's running
curl http://localhost:11434/api/tags

# Docker on WSL — make sure host.docker.internal resolves
docker run --rm alpine ping -c1 host.docker.internal
```

On WSL, Ollama typically runs on the **Windows** side (not inside WSL). The default `OLLAMA_HOST=http://host.docker.internal:11434` handles this — don't change it unless you know what you're doing.

---

## The Model

This project uses [Gemma-4-E2B-Uncensored-HauhauCS-Aggressive](https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive) by HauhauCS — an abliterated Q6_K quantisation of Google's Gemma 4. "Abliteration" refers to the removal of refusal vectors from the model weights, meaning it will not reject requests based on content policy.

| Detail | Value |
|--------|-------|
| Base model | Google Gemma 4 (4B) |
| Quantisation | Q6_K (3.7 GB) |
| Context window | 4096 tokens |
| Speed (RX 580) | ~15 tok/s |
| Speed (RTX 3060) | ~40+ tok/s |

**Important**: This model has no safety filtering. Deploy responsibly and behind authentication if exposed to the internet.

---

## Roadmap

- [ ] Multi-user session support
- [ ] SSH-style authentication
- [ ] Model switching (Gemma ↔ Llama ↔ Mistral)
- [ ] Chat history persistence
- [ ] Mobile PWA
- [ ] Voice input

---

## Contributing

Pull requests welcome. This is a weekend project — there's plenty of rough edges.

1. Fork it
2. Branch it (`git checkout -b feat/cool-thing`)
3. Commit it (`git commit -m 'feat: add cool thing'`)
4. Push it (`git push origin feat/cool-thing`)
5. PR it

---

## License

MIT — do whatever you want. Just don't be a dick about it.

---

<div align="center">

**Built with terminal green and bad intentions.**

`curl -sL https://raw.githubusercontent.com/ob4cl/gmajail/main/scripts/install.sh | bash`

</div>
