FROM caddy:2-builder@sha256:3db37b69486800de84befa0dd692b4023beb435421703bbdb6f84a8055ddf011 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:f848613a14e81ddf87d67c67f3b011be5849068fd2cc8ab8d1c421b153f74fcc

COPY --from=builder /usr/bin/caddy /usr/bin/caddy