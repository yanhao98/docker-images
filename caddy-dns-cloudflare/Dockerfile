FROM caddy:2-builder@sha256:db5fb4f8130084edb46aa89bef084a184c832a42e9f537ec6326ef12d2945bcc AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:b8c90e126558630ac99b6df3daf4aa261e80dd0bd28f8b4882be4f31d783706d

COPY --from=builder /usr/bin/caddy /usr/bin/caddy