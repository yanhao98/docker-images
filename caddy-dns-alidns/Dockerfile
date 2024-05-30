FROM caddy:2-builder@sha256:d5e1e8eaee0648202bfdfc169bffc93496ab839b77bfc8cc39e29cb0da961f9b AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:93e6895f3efa1039ad30dc6a9542d24a0f4eef27363d3026484e0b82d3f1b613

COPY --from=builder /usr/bin/caddy /usr/bin/caddy