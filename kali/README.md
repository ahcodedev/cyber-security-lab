# Kali desktop

The attacker machine shared by every lab: a Kali Linux XFCE desktop that you use from your host browser. Each lab's `compose.yaml` includes `compose.yaml` from this directory, so all labs run the same image and share one home directory.

## Usage

Start any lab with its `just <lab>-up` command, then open <http://127.0.0.1:6080/vnc.html> and enter the password `kalilab`.

- **Password**: set the `VNC_PASSWORD` environment variable before starting a lab to change it. VNC uses only the first 8 characters.
- **User**: you are logged in as `kali`, with passwordless `sudo`.
- **Targets**: reach a lab's services by name from the Kali browser or terminal, for example `http://juice-shop:3000`.

## What is installed

- `kali-linux-default`, Kali's standard toolset, including Metasploit, nmap, sqlmap, Wireshark and Firefox.
- Burp Suite and ZAP, added separately.
- nuclei, with its template library baked into the image at `/opt/nuclei-templates`. nuclei normally downloads templates at runtime, which the offline lab cannot do. They are as old as the last image build; rebuild to refresh them. Example: `nuclei -u http://dvwa/login.php -tags dvwa`.

## Services

| Service   | Purpose                                                                                                   |
| --------- | --------------------------------------------------------------------------------------------------------- |
| `kali`    | The desktop: XFCE on a TigerVNC server, served to the browser by noVNC on port 6080                       |
| `gateway` | A socat forwarder and the only container attached to both networks; it publishes port 6080 on `127.0.0.1` |

| Network | Purpose                                                                                 |
| ------- | --------------------------------------------------------------------------------------- |
| `lab`   | Internal network for Kali and the targets; no route to the host network or the internet |
| `edge`  | Normal network used only by `gateway` to publish the desktop                            |

## Persistence

`/home/kali` is stored in the `kali-home` Docker volume, which every lab shares, so notes and Burp projects survive stops and lab switches. Everything outside the home directory resets when a lab stops.

The volume is created by the `just <lab>-up` commands. Starting a lab with a bare `docker compose up` fails if the volume does not exist yet.

## Adding or updating tools

The container has no internet access, so `apt install` does not work at runtime. Edit `Dockerfile` and rebuild instead:

```sh
docker compose -f kali/compose.yaml build --pull --no-cache kali
```

The image is about 18 GB and a full rebuild takes a long time.

The base image is pinned by digest in `Dockerfile`, so `--pull` does not move it. To update it, replace the digest with the `Digest:` line from `docker buildx imagetools inspect kalilinux/kali-rolling:latest`. Packages still come from the live Kali mirrors at build time.
