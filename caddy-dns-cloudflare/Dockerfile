FROM caddy:2-builder@sha256:e7f6eabf609716e91d0058247dffa119f11abe8ab1adc61b88ce4b86cdcda6ae AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:2c7c4a3b9534b34d598a02e7d2be61d3b3355fb77245aea43c27c6d93e09d55f

COPY --from=builder /usr/bin/caddy /usr/bin/caddy