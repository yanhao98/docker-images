# syntax=docker/dockerfile:1
FROM caddy:2

ENV API_PROXY_TARGET=api:3000
ENV API_PROXY_ROUTE_PREFIX=/API
ENV API_PROXY_PATH_PREFIX=

COPY <<'EOF' /etc/caddy/Caddyfile
:80 {
  # 不保留 API 路由前缀，可选追加后端路径前缀后再转发到后端
  handle_path {$API_PROXY_ROUTE_PREFIX}/* {
    rewrite * {$API_PROXY_PATH_PREFIX}{uri}
    reverse_proxy {$API_PROXY_TARGET}
  }

  handle {
    root * /usr/share/caddy
    try_files {path} /index.html
    file_server
  }
}
EOF
