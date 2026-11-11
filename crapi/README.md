# crAPI lab

[crAPI](https://owasp.org/www-project-crapi/) (Completely Ridiculous API) is OWASP's deliberately vulnerable API application. It models a car-owner portal with a shop, a mechanic workshop and a community forum, built from several services behind one web front end. It is aimed at API flaws such as the OWASP API Security Top 10, for example broken object-level authorization.

## Usage

```sh
just crapi-up     # build and start
just crapi-down   # stop
```

1. Run `just crapi-up`. The services start in order and wait for each other, so this takes a minute or two.
2. Open the [Kali desktop](../kali/README.md) at <http://127.0.0.1:6080/vnc.html>.
3. In the Kali browser, go to `http://crapi-web` and sign up for an account.
4. Open MailHog at `http://mailhog:8025` to read the emails crAPI sends you, such as the vehicle details needed to add your car.

## Services

| Service                       | Image                   | Purpose                                        |
| ----------------------------- | ----------------------- | ---------------------------------------------- |
| `crapi-web`                   | `crapi/crapi-web`       | Web front end and API entry point, on port 80  |
| `crapi-identity`              | `crapi/crapi-identity`  | Accounts, login and tokens                     |
| `crapi-community`             | `crapi/crapi-community` | Forum posts and coupons                        |
| `crapi-workshop`              | `crapi/crapi-workshop`  | Shop and mechanic workshop                     |
| `mailhog`                     | `crapi/mailhog`         | Catches outgoing email; web UI on port 8025    |
| `api.mypremiumdealership.com` | `crapi/gateway-service` | Simulated external partner API                 |
| `postgresdb`                  | `postgres:14`           | Relational database                            |
| `mongodb`                     | `mongo:4.4`             | Document database                              |
| `kali`                        | `lab-kali`              | Attacker desktop                               |
| `gateway`                     | `alpine/socat`          | Publishes the Kali desktop on `127.0.0.1:6080` |

## How the lab behaves

- **Isolated**: the target and Kali sit on an internal Docker network with no internet access. The target is not published to the host, so it is reachable only from inside Kali.
- **Auto-off**: the lab shuts itself down after 2 hours. Pass minutes to change it, for example `just crapi-up 30`. The timer only applies when the lab is started through `just`.
- **One lab at a time**: starting this lab stops any other lab that is running.
- **Resets on stop**: neither database is persisted, so accounts, vehicles and emails are lost when the lab stops. Files under `/home/kali` are kept; see the [Kali desktop](../kali/README.md).

## Notes

- `compose.yaml` is adapted from crAPI's upstream `deploy/docker/docker-compose.yml` and keeps its stock credentials. They are public defaults, which is acceptable only because the lab network is isolated.
- **No chatbot**: crAPI's chatbot needs an OpenAI API key and internet access, so it and its vector database are left out. The chatbot widget in the app returns an error.
- The `crapi-web` service carries the network alias `crapi-chatbot` because its nginx will not start unless that hostname resolves.
- Every service is reachable from Kali by its service name, not only the web front end.
