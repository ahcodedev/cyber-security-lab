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

Requires Docker. Each lab pairs a deliberately vulnerable target with a shared [Kali desktop](kali/README.md) on an isolated Docker network. One lab runs at a time, and each shuts itself down after 2 hours.

| Lab                                     | Target                                     | Start                | Stop                   |
| --------------------------------------- | ------------------------------------------ | -------------------- | ---------------------- |
| [Juice Shop](owasp_juiceshop/README.md) | Insecure online shop (web app)             | `just juice-shop-up` | `just juice-shop-down` |
| [DVWA](dvwa/README.md)                  | One page per vulnerability class (PHP)     | `just dvwa-up`       | `just dvwa-down`       |
| [crAPI](crapi/README.md)                | Vulnerable API application (microservices) | `just crapi-up`      | `just crapi-down`      |

After starting a lab, open the Kali desktop at <http://127.0.0.1:6080/vnc.html> (password `kalilab`). Each lab's README covers its usage.

## Security checks

| Command         | Purpose                           |
| --------------- | --------------------------------- |
| `just gitleaks` | Scan git history for secrets      |
| `just zizmor`   | Audit GitHub Actions workflows    |
| `prek run -a`   | Run the pre-commit hooks manually |

Both checks run on commit via prek and in CI via `.github/workflows/security.yml`.
