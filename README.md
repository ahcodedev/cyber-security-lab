# Cybersecurity Lab

[![Security](https://github.com/ahcodedev/cyber-security-lab/actions/workflows/security.yml/badge.svg?branch=main)](https://github.com/ahcodedev/cyber-security-lab/actions/workflows/security.yml)
[![gitleaks](https://img.shields.io/badge/protected%20by-gitleaks-blue)](https://github.com/gitleaks/gitleaks)
[![zizmor](https://img.shields.io/badge/%F0%9F%8C%88-zizmor-white?labelColor=white)](https://zizmor.sh/)

Cybersecurity Lab Environment

## Setup

```sh
brew bundle
prek install
```

## Lab

Requires Docker. The lab lives in `owasp_juiceshop/`: OWASP Juice Shop (target) and a Kali desktop (attacker) run on an internal Docker network with no internet access.

| Command                 | Purpose                                         |
| ----------------------- | ----------------------------------------------- |
| `just juice-shop-up`    | Build and start the lab; auto-off after 2 hours |
| `just juice-shop-up 30` | Same, with auto-off after 30 minutes            |
| `just juice-shop-down`  | Stop the lab                                    |

- Kali desktop: <http://127.0.0.1:6080/vnc.html>, password `kalilab` (override with `VNC_PASSWORD`, max 8 characters).
- Juice Shop is reachable only from inside Kali, at `http://juice-shop:3000`.
- `/home/kali` persists in the `kali-home` volume; everything else resets on `just juice-shop-down`.
- To add or update tools, edit `owasp_juiceshop/kali/Dockerfile` and run `docker compose -f owasp_juiceshop/compose.yaml build --pull --no-cache kali`.

## Security checks

| Command         | Purpose                           |
| --------------- | --------------------------------- |
| `just gitleaks` | Scan git history for secrets      |
| `just zizmor`   | Audit GitHub Actions workflows    |
| `prek run -a`   | Run the pre-commit hooks manually |

Both checks run on commit via prek and in CI via `.github/workflows/security.yml`.
    