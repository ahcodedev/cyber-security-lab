# OWASP WebGoat lab

[OWASP WebGoat](https://owasp.org/www-project-webgoat/) is a deliberately insecure Java web application for learning web security. Lessons explain a vulnerability and then ask you to exploit it. WebWolf, a helper app that plays the attacker's server (file hosting, a mailbox and a request catcher), runs in the same container.

## Usage

```sh
just webgoat-up     # build and start
just webgoat-down   # stop
```

1. Run `just webgoat-up`.
2. Open the [Kali desktop](../kali/README.md) at <http://127.0.0.1:6080/vnc.html>.
3. In the Kali browser, go to `http://webgoat:8080/WebGoat`.
4. Register your own account (username of 6 or more lowercase characters). WebWolf is at `http://webgoat:9090/WebWolf` and uses the same login.

## Services

| Service   | Image             | Purpose                                                         |
| --------- | ----------------- | --------------------------------------------------------------- |
| `webgoat` | `webgoat/webgoat` | WebGoat on port 8080 (`/WebGoat`), WebWolf on 9090 (`/WebWolf`) |
| `kali`    | `lab-kali`        | Attacker desktop                                                |
| `gateway` | `alpine/socat`    | Publishes the Kali desktop on `127.0.0.1:6080`                  |

## How the lab behaves

- **Isolated**: the target and Kali sit on an internal Docker network with no internet access. The target is not published to the host, so it is reachable only from inside Kali.
- **Auto-off**: the lab shuts itself down after 2 hours. Pass minutes to change it, for example `just webgoat-up 30`. The timer only applies when the lab is started through `just`.
- **One lab at a time**: starting this lab stops any other lab that is running.
- **Resets on stop**: WebGoat keeps no data between runs, so accounts and lesson progress are lost when the lab stops. Files under `/home/kali` are kept; see the [Kali desktop](../kali/README.md).

## Notes

- The image name `webgoat/webgoat` comes from the official repo README. It is pinned by digest in `compose.yaml`.
- `WEBGOAT_HOST` and `WEBWOLF_HOST` are set to `webgoat` so links between the two apps use the service name.
- Docker shows the container as `unhealthy`: the image's built-in healthcheck calls `curl`, which the image does not include. The apps still work.
- Burp Suite and ZAP are installed in Kali.
