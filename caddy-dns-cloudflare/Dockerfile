FROM caddy:2-builder@sha256:2c0c92e25b366bd8e612302512c99d03dec66eb3be55a3e9b187cab962770119 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:83d99edad2f0ac5e52068e065e42bd40c4ff7465a8f582482566c9d48350663a

COPY --from=builder /usr/bin/caddy /usr/bin/caddy