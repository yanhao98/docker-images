FROM caddy:2.8.4-builder AS builder
RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2.8.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy