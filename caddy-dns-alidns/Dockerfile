FROM caddy:2-builder@sha256:3db37b69486800de84befa0dd692b4023beb435421703bbdb6f84a8055ddf011 AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/alidns

FROM caddy:2@sha256:9a8e0e6f0f0af954626903b1ae5aac3536f45222131c01e1f2433e8b1ecb3937

COPY --from=builder /usr/bin/caddy /usr/bin/caddy