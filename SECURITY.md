# Security Policy

## Reporting a Vulnerability

If you discover a security issue in gmajail, please do **not** open a public issue.

Email: **security@ob4cl.dev** (or DM @ob4cl on GitHub)

Include:
- Description of the vulnerability
- Steps to reproduce
- Impact assessment

You'll get a response within 48 hours. We'll coordinate disclosure and credit.

## Supported Versions

| Version | Supported |
|---------|-----------|
| main    | ✅        |

## Scope

- The WebSocket endpoint (`/ws`) and HTTP server
- Docker configuration and deployment
- CI/CD pipeline security
- The model itself is *intentionally* uncensored — jailbreak/prompt injection against the model is out of scope
