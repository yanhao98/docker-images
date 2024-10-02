FROM caddy:2-builder@sha256:3c563343241f66d4efa68157791640bbb960f7726ef3096e20bd8e8066b0ccc6 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:c6a5f2835a53fd9e2b5e0623dc7ebf0f89c163c21c05cbbc35e4ea31ff424417

COPY --from=builder /usr/bin/caddy /usr/bin/caddy