FROM caddy:2-builder@sha256:37acf9e88ea74ef051bc1ec68ea9abd535320ea4eea1a0162aaf378ee5200a3c AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:f848613a14e81ddf87d67c67f3b011be5849068fd2cc8ab8d1c421b153f74fcc

COPY --from=builder /usr/bin/caddy /usr/bin/caddy