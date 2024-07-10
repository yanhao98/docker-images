FROM caddy:2-builder@sha256:62a63f27175da4481927333c7d3d8c59e29a2307a0b183b645ddfd6f79d03b7b AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:d4c3d1d98f070f36d21eff1e7521edb718704a9f906618708b06946b9eb4f448

COPY --from=builder /usr/bin/caddy /usr/bin/caddy