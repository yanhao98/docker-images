FROM caddy:2-builder@sha256:93b7c47f8ad5db9e6662e6018efcf3b3aede09c400b3978dee435972c3f55e2a AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:93e6895f3efa1039ad30dc6a9542d24a0f4eef27363d3026484e0b82d3f1b613

COPY --from=builder /usr/bin/caddy /usr/bin/caddy