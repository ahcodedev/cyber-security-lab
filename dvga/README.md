# DVGA lab

[Damn Vulnerable GraphQL Application](https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application) (DVGA) is a deliberately vulnerable pastebin-style app with a GraphQL API. It covers GraphQL-specific flaws such as introspection, batching and deep-query denial of service, as well as injection, broken authorization and SSRF. It has a Beginner and an Expert difficulty.

## Usage

```sh
just dvga-up     # build and start
just dvga-down   # stop
```

1. Run `just dvga-up`.
2. Open the [Kali desktop](../kali/README.md) at <http://127.0.0.1:6080/vnc.html>.
3. In the Kali browser, go to `http://dvga:5013`. No setup is needed.
4. The API is at `http://dvga:5013/graphql`, with GraphiQL at `http://dvga:5013/graphiql`. The app's users are `admin` / `changeme` and `operator` / `password123`.

## Services

| Service   | Image          | Purpose                                        |
| --------- | -------------- | ---------------------------------------------- |
| `dvga`    | `dolevf/dvga`  | The target application, on port 5013           |
| `kali`    | `lab-kali`     | Attacker desktop                               |
| `gateway` | `alpine/socat` | Publishes the Kali desktop on `127.0.0.1:6080` |

## How the lab behaves

- **Isolated**: the target and Kali sit on an internal Docker network with no internet access. The target is not published to the host, so it is reachable only from inside Kali.
- **Auto-off**: the lab shuts itself down after 2 hours. Pass minutes to change it, for example `just dvga-up 30`. The timer only applies when the lab is started through `just`.
- **One lab at a time**: starting this lab stops any other lab that is running.
- **Resets on stop**: DVGA rebuilds its database on every start, so pastes and changes are lost when the lab stops. Files under `/home/kali` are kept; see the [Kali desktop](../kali/README.md).

## Notes

- The image name `dolevf/dvga` comes from the official repo README. It is pinned by digest in `compose.yaml` and is amd64 only, so it runs under emulation on Apple Silicon.
- Burp Suite is installed in Kali. GraphQL tools such as InQL, graphw00f and clairvoyance are not.
- The paste import feature fetches from outside websites by default, which fails without internet. Point it at a lab host instead, for example for SSRF.
