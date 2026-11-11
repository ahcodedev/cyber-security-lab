# DVWA lab

[Damn Vulnerable Web Application](https://github.com/digininja/DVWA) (DVWA) is a PHP and MariaDB application with one page per vulnerability class, such as SQL injection, command injection, file upload, CSRF and XSS. Each page can be set to a different difficulty, which makes it suited to practising one technique at a time.

## Usage

```sh
just dvwa-up     # build and start
just dvwa-down   # stop
```

1. Run `just dvwa-up`.
2. Open the [Kali desktop](../kali/README.md) at <http://127.0.0.1:6080/vnc.html>.
3. In the Kali browser, go to `http://dvwa/setup.php` and click **Create / Reset Database**. This is needed after every start.
4. Log in at `http://dvwa` as `admin` with the password `password`.
5. Choose a difficulty under **DVWA Security**. It starts on `impossible`, the hardened setting; pick `low` to begin.

## Services

| Service   | Image                    | Purpose                                        |
| --------- | ------------------------ | ---------------------------------------------- |
| `dvwa`    | `ghcr.io/digininja/dvwa` | The target application, on port 80             |
| `db`      | `mariadb:10`             | DVWA's database                                |
| `kali`    | `lab-kali`               | Attacker desktop                               |
| `gateway` | `alpine/socat`           | Publishes the Kali desktop on `127.0.0.1:6080` |

## How the lab behaves

- **Isolated**: the target and Kali sit on an internal Docker network with no internet access. The target is not published to the host, so it is reachable only from inside Kali.
- **Auto-off**: the lab shuts itself down after 2 hours. Pass minutes to change it, for example `just dvwa-up 30`. The timer only applies when the lab is started through `just`.
- **One lab at a time**: starting this lab stops any other lab that is running.
- **Resets on stop**: the database is not persisted, so it is empty on every start and must be created again in step 3. Files under `/home/kali` are kept; see the [Kali desktop](../kali/README.md).

## Notes

- The database uses DVWA's stock credentials, set in `compose.yaml`. They are public defaults, which is acceptable only because the lab network is isolated.
- The `db` service is also reachable from Kali on port 3306.
