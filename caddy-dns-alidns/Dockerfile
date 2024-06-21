FROM caddy:2-builder@sha256:2c0c92e25b366bd8e612302512c99d03dec66eb3be55a3e9b187cab962770119 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:4b192bcff3499aa887e3a0e99cb1773f3502e72389e4bb1699cae4af2938f45e

COPY --from=builder /usr/bin/caddy /usr/bin/caddy