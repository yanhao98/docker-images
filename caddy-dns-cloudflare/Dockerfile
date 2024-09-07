FROM caddy:2-builder@sha256:a68f335e9477f7bd7d233ebcbc615ba94e69f1e384cb18a7480dd01662c54041 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:2b390571e3b33257843ccd39cc6e5644fca60cd1a17116a3b94d1ba89e88fda6

COPY --from=builder /usr/bin/caddy /usr/bin/caddy