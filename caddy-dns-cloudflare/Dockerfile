FROM caddy:2.9-builder AS builder
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.9
COPY --from=builder /usr/bin/caddy /usr/bin/caddy


# --with github.com/caddyserver/replace-response
# :80 {
# 	reverse_proxy x.x.x.x {
# 		header_up Accept-Encoding identity
# 	}
# 	route {
# 		replace "Hello, world!" "Hello, Caddy!"
# 	}
# }
