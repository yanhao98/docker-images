FROM caddy:2-builder@sha256:d5e1e8eaee0648202bfdfc169bffc93496ab839b77bfc8cc39e29cb0da961f9b AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2@sha256:ccdad842a0f34a8db14fa0671113f9567d65ba3798220539467d235131a3ed63

COPY --from=builder /usr/bin/caddy /usr/bin/caddy