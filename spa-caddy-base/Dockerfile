# syntax=docker/dockerfile:1
FROM caddy:2

ENV API_PROXY_TARGET=api:3000

COPY <<'EOF' /etc/caddy/Caddyfile
:80 {
  # 不保留原始路径，直接转发到后端
  handle_path /API/* {
    reverse_proxy {$API_PROXY_TARGET}
  }

  handle {
    root * /usr/share/caddy
    try_files {path} /index.html
    file_server
  }
}
EOF
