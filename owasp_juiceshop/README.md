# OWASP Juice Shop lab

[OWASP Juice Shop](https://owasp.org/www-project-juice-shop/) is a deliberately insecure online shop written in Node.js and Angular. It is a single web application with a large set of hacking challenges covering the OWASP Top 10 and more, tracked on a built-in score board.

## Usage

```sh
just juice-shop-up     # build and start
just juice-shop-down   # stop
```

1. Run `just juice-shop-up`.
2. Open the [Kali desktop](../kali/README.md) at <http://127.0.0.1:6080/vnc.html>.
3. In the Kali browser, go to `http://juice-shop:3000`.
4. Register your own shop account to begin. Finding the score board is the first challenge.

## Services

| Service      | Image                   | Purpose                                        |
| ------------ | ----------------------- | ---------------------------------------------- |
| `juice-shop` | `bkimminich/juice-shop` | The target shop, on port 3000                  |
| `kali`       | `lab-kali`              | Attacker desktop                               |
| `gateway`    | `alpine/socat`          | Publishes the Kali desktop on `127.0.0.1:6080` |

## How the lab behaves

- **Isolated**: the target and Kali sit on an internal Docker network with no internet access. The target is not published to the host, so it is reachable only from inside Kali.
- **Auto-off**: the lab shuts itself down after 2 hours. Pass minutes to change it, for example `just juice-shop-up 30`. The timer only applies when the lab is started through `just`.
- **One lab at a time**: starting this lab stops any other lab that is running.
- **Resets on stop**: Juice Shop keeps no data between runs, so accounts, orders and solved challenges are lost when the lab stops. Files under `/home/kali` are kept; see the [Kali desktop](../kali/README.md).

## Notes

- Most challenges are solved with a browser and an intercepting proxy. Burp Suite and ZAP are installed in Kali.
- Challenges that depend on outside websites cannot be completed, because the lab has no internet access.
