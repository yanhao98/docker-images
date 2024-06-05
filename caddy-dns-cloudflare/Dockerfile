FROM caddy:2-builder@sha256:3db37b69486800de84befa0dd692b4023beb435421703bbdb6f84a8055ddf011 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:51b5e778a16d77474c37f8d1d966e6863cdb1c7478396b04b806169fed0abac9

COPY --from=builder /usr/bin/caddy /usr/bin/caddy