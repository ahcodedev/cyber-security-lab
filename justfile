[private]
list:
    @just --list

# Scan git history for secrets
gitleaks *args:
    gitleaks git --redact --verbose {{ args }}

# Audit GitHub Actions workflows
zizmor *args:
    zizmor {{ args }} .

# Check every container image is pinned by digest (locally built `lab-*` images are exempt)
check-digests:
    #!/usr/bin/env sh
    unpinned=$(grep -rnE --exclude-dir=.git --include='*compose*.yaml' --include='*compose*.yml' --include='Dockerfile*' \
        '^[[:space:]]*(image:|FROM[[:space:]])' . | grep -v '@sha256:' | grep -vE 'image:[[:space:]]*lab-|FROM[[:space:]]+scratch')
    if [ -n "$unpinned" ]; then
        echo "Images not pinned by digest:"
        echo "$unpinned"
        exit 1
    fi

# Start the Juice Shop lab; it shuts itself down after `ttl` minutes
juice-shop-up ttl="120": (lab-up "owasp_juiceshop" ttl)

# Stop the Juice Shop lab
juice-shop-down: lab-down

# Start the DVWA lab; it shuts itself down after `ttl` minutes
dvwa-up ttl="120": (lab-up "dvwa" ttl)

# Stop the DVWA lab
dvwa-down: lab-down

# Start the crAPI lab; it shuts itself down after `ttl` minutes
crapi-up ttl="120": (lab-up "crapi" ttl)

# Stop the crAPI lab
crapi-down: lab-down

# Start the DVGA lab; it shuts itself down after `ttl` minutes
dvga-up ttl="120": (lab-up "dvga" ttl)

# Stop the DVGA lab
dvga-down: lab-down

# Labs share the Kali desktop port, so only one runs at a time.
[private]
lab-up dir ttl: lab-down
    @docker volume create kali-home >/dev/null
    docker compose -f {{ dir }}/compose.yaml up -d --build
    nohup sh -c 'sleep $(({{ ttl }} * 60)) && docker compose -f {{ dir }}/compose.yaml down' lab-auto-off >/dev/null 2>&1 &
    @echo "Kali desktop: http://127.0.0.1:6080/vnc.html (auto-off in {{ ttl }} min)"

[private]
lab-down:
    -@pkill -f '[l]ab-auto-off'
    docker compose -f owasp_juiceshop/compose.yaml down
    docker compose -f dvwa/compose.yaml down
    docker compose -f crapi/compose.yaml down
    docker compose -f dvga/compose.yaml down
