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

## Labs

Requires Docker. Each lab pairs a vulnerable target with the shared Kali desktop in `kali/` on an internal Docker network with no internet access. Only one lab runs at a time; starting one stops the other.

| Command                 | Purpose                                                    |
| ----------------------- | ---------------------------------------------------------- |
| `just juice-shop-up`    | Build and start the Juice Shop lab; auto-off after 2 hours |
| `just dvwa-up`          | Build and start the DVWA lab; auto-off after 2 hours       |
| `just juice-shop-up 30` | Either `up` command takes an auto-off time in minutes      |
| `just juice-shop-down`  | Stop the lab (`just dvwa-down` does the same)              |

| Lab        | Directory          | Target URL inside Kali   | Notes                                                              |
| ---------- | ------------------ | ------------------------ | ------------------------------------------------------------------ |
| Juice Shop | `owasp_juiceshop/` | `http://juice-shop:3000` |                                                                    |
| DVWA       | `dvwa/`            | `http://dvwa`            | Log in as `admin` / `password`, then click Create / Reset Database |

- Kali desktop: <http://127.0.0.1:6080/vnc.html>, password `kalilab` (override with `VNC_PASSWORD`, max 8 characters).
- Targets are reachable only from inside Kali.
- `/home/kali` persists in the `kali-home` volume, shared by both labs; everything else resets when a lab stops.
- To add or update tools, edit `kali/Dockerfile` and run `docker compose -f kali/compose.yaml build --pull --no-cache kali`.

## Security checks

| Command         | Purpose                           |
| --------------- | --------------------------------- |
| `just gitleaks` | Scan git history for secrets      |
| `just zizmor`   | Audit GitHub Actions workflows    |
| `prek run -a`   | Run the pre-commit hooks manually |

Both checks run on commit via prek and in CI via `.github/workflows/security.yml`.
