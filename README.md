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
| [DVGA](dvga/README.md)                  | Vulnerable GraphQL API (Python)            | `just dvga-up`       | `just dvga-down`       |
| [WebGoat](webgoat/README.md)            | Guided lessons with WebWolf helper (Java)  | `just webgoat-up`    | `just webgoat-down`    |

After starting a lab, open the Kali desktop at <http://127.0.0.1:6080/vnc.html> (password `kalilab`). Each lab's README covers its usage.

## Security checks

| Command              | Purpose                                      |
| -------------------- | -------------------------------------------- |
| `just gitleaks`      | Scan git history for secrets                 |
| `just zizmor`        | Audit GitHub Actions workflows               |
| `just check-digests` | Check every container image is digest-pinned |
| `prek run -a`        | Run the pre-commit hooks manually            |

All three checks run on commit via prek and in CI via `.github/workflows/security.yml`.

## Ready-made online platforms

Hosted alternatives that need no local setup.

### Offensive and bug bounty

- [PortSwigger Web Security Academy](https://portswigger.net/web-security): free, browser-based labs. The best place to start for bug bounty.
- [TryHackMe](https://tryhackme.com): the most beginner-friendly, with guided rooms and a browser-based attack machine.
- [Hack The Box](https://www.hackthebox.com): harder standalone machines, plus HTB Academy (structured courses) and Pro Labs (full corporate networks with AD).
- [OffSec Proving Grounds](https://www.offsec.com/products/proving-grounds/): good practice if you're aiming for the OSCP.
- [PentesterLab](https://pentesterlab.com): web-focused, with good write-ups of real vulnerability classes.

### CTF and wargames

- [picoCTF](https://picoctf.org): free, beginner CTF from Carnegie Mellon, open all year.
- [OverTheWire](https://overthewire.org/wargames/): wargames played over SSH. Bandit is the classic way to learn the Linux command line.
- [pwn.college](https://pwn.college): free courses from Arizona State on binary exploitation and systems security.
- [Hacker101 CTF](https://ctf.hacker101.com): HackerOne's free CTF. Solving challenges can earn private bug bounty invites.
- [Root Me](https://www.root-me.org): a large catalogue of challenges across web, crypto, forensics and networking.
- [CTFtime](https://ctftime.org): calendar and rankings for live CTF events.
- [Google CTF](https://capturetheflag.withgoogle.com): includes a yearly Beginner's Quest track.

### Web and bug bounty challenges

- [Intigriti monthly challenges](https://challenge.intigriti.io) and [YesWeHack Dojo](https://dojo-yeswehack.com): free XSS and web puzzles from bug bounty platforms.
- [BugBountyHunter.com](https://www.bugbountyhunter.com): realistic web apps built around real bug bounty findings.
- [HackingHub](https://www.hackinghub.io): short labs tied to specific vulnerability classes and tools.

### Binary exploitation and reversing

- [ROP Emporium](https://ropemporium.com): a progression of return-oriented programming challenges.
- [Exploit Education](https://exploit.education) (Phoenix, Nebula): downloadable VMs for memory corruption and Linux privilege escalation.
- [pwnable.kr](https://pwnable.kr) and [pwnable.tw](https://pwnable.tw): classic pwn challenges, from easy to very hard.
- [Microcorruption](https://microcorruption.com): embedded exploitation in a browser-based debugger.
- [crackmes.one](https://crackmes.one): community reverse-engineering challenges.

### Crypto

- [CryptoHack](https://cryptohack.org): interactive crypto challenges.
- [Cryptopals](https://cryptopals.com): the classic set of crypto-breaking exercises.

### Boot-to-root and Active Directory

- [VulnHub](https://www.vulnhub.com): vulnerable VMs you download and run yourself.
- [HackMyVM](https://hackmyvm.eu): free downloadable vulnerable VMs, similar to VulnHub.
- [Vulnlab](https://www.vulnlab.com): AD and multi-machine chains.

### Cloud

- [flAWS](http://flaws.cloud) and [flAWS2](http://flaws2.cloud): free AWS misconfiguration challenges.
- [Pwned Labs](https://pwnedlabs.io): cloud pentesting labs for AWS, Azure and GCP.

### Defensive and detection

- [LetsDefend](https://letsdefend.io) and [CyberDefenders](https://cyberdefenders.org): simulated SOC alerts and investigation challenges.
- [Blue Team Labs Online](https://blueteamlabs.online): incident response and forensics challenges.
- [Splunk Boss of the SOC (BOTS) datasets](https://github.com/splunk/botsv3): real-world-style log data you can search.
- [TryHackMe SOC Level 1](https://tryhackme.com/path/outline/soclevel1): guided path for SOC analyst skills.
- [malware-traffic-analysis.net](https://www.malware-traffic-analysis.net): packet captures with exercises, good for Wireshark practice.
