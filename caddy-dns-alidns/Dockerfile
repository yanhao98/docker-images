FROM caddy:2.9.0-builder AS builder
RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2.9.0
COPY --from=builder /usr/bin/caddy /usr/bin/caddy