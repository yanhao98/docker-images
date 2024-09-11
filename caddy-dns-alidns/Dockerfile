FROM caddy:2-builder@sha256:5e05b57b569a3b9a19567321e839560e49a559f31442f92f92c411086ce9e190 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:c6a5f2835a53fd9e2b5e0623dc7ebf0f89c163c21c05cbbc35e4ea31ff424417

COPY --from=builder /usr/bin/caddy /usr/bin/caddy