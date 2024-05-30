FROM caddy:2-builder@sha256:93b7c47f8ad5db9e6662e6018efcf3b3aede09c400b3978dee435972c3f55e2a AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:236c6a30ccb84fa412a5360ca8b586d804faba0621ea182fb45902608cd8a563

COPY --from=builder /usr/bin/caddy /usr/bin/caddy