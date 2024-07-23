FROM caddy:2-builder@sha256:efb0a066246f690811b6063d74e5ba633f62286ed15f39f6eb3d05c2a870a2fe AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:05ffb4db663de72e028e2ba8298c2e8eb6f0f8b240012cd6472903ab35639f98

COPY --from=builder /usr/bin/caddy /usr/bin/caddy