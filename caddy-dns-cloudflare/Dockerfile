FROM caddy:2-builder@sha256:d3f3b4e66402ae739f1005fa41f8ea024c3f5fc3a0667ee6c1b37f402ce4be28 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:c1decd182b7e456929f0c6cff6b70d14b316cd195b7adebe3d9b5c100f1c2b32

COPY --from=builder /usr/bin/caddy /usr/bin/caddy