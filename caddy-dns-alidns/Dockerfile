FROM caddy:2-builder@sha256:150c52a85b5d63f5c5892c20725df06669e8abf749584bfc24d3fa92f28c3ab4 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:2ae8f7fcd4d82d1c5c1c4dc45ad5f24ab1c1f3af4dd6db03a83d126047d7a939

COPY --from=builder /usr/bin/caddy /usr/bin/caddy