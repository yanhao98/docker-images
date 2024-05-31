FROM caddy:2-builder@sha256:93a0320af6e247362974f8606f1659b977b8c4421282682844a197b26b4be924 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:7414db60780a20966cd9621d1dcffcdcef060607ff32ddbfde2a3737405846c4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy