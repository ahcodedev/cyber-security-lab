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

## Security checks

| Command         | Purpose                           |
| --------------- | --------------------------------- |
| `just gitleaks` | Scan git history for secrets      |
| `just zizmor`   | Audit GitHub Actions workflows    |
| `prek run -a`   | Run the pre-commit hooks manually |

Both checks run on commit via prek and in CI via `.github/workflows/security.yml`.
    