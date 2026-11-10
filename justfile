[private]
list:
    @just --list

# Scan git history for secrets
gitleaks *args:
    gitleaks git --redact --verbose {{ args }}

# Audit GitHub Actions workflows
zizmor *args:
    zizmor {{ args }} .
