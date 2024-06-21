FROM caddy:2-builder@sha256:2c0c92e25b366bd8e612302512c99d03dec66eb3be55a3e9b187cab962770119 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:05efaa6ec0363f5a3e37489aa60c2aed6707311c9b30c63dee598a5cfd742d97

COPY --from=builder /usr/bin/caddy /usr/bin/caddy