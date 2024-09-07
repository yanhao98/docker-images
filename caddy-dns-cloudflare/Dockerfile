FROM caddy:2-builder@sha256:b37224d6be513d3d083bc7e95c6d97dd6bed82966972950ae9d1d8139ac60f8b AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:b0a9578605b30ed6f6d75b66b31042628ca89707ef665385c100f7957a38b0f3

COPY --from=builder /usr/bin/caddy /usr/bin/caddy