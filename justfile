compose := "docker compose -f owasp_juiceshop/compose.yaml"

[private]
list:
    @just --list

# Scan git history for secrets
gitleaks *args:
    gitleaks git --redact --verbose {{ args }}

# Audit GitHub Actions workflows
zizmor *args:
    zizmor {{ args }} .

# Start the lab; it shuts itself down after `ttl` minutes
juice-shop-up ttl="120": juice-shop-timer-cancel
    {{ compose }} up -d --build
    nohup sh -c 'sleep $(({{ ttl }} * 60)) && {{ compose }} down' juice-shop-auto-off >/dev/null 2>&1 &
    @echo "Kali desktop: http://127.0.0.1:6080/vnc.html (auto-off in {{ ttl }} min)"

# Stop the lab
juice-shop-down: juice-shop-timer-cancel
    {{ compose }} down

[private]
juice-shop-timer-cancel:
    -@pkill -f '[j]uice-shop-auto-off'
