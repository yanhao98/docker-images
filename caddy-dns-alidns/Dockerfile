FROM caddy:2-builder@sha256:2f44de947418f8155bcf3c84397083bd0deb61eb19efa39094184fa7c53b68e4 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:60199fbf2046892e0aa4b19c7d3adf71f530c36abc65728627422148a75b3475

COPY --from=builder /usr/bin/caddy /usr/bin/caddy