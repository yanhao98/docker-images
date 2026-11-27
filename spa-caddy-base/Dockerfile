# syntax=docker/dockerfile:1
FROM caddy:2

ENV API_PROXY_TARGET=api:3000
ENV API_PROXY_ROUTE_PREFIX=/API
ENV API_PROXY_PATH_PREFIX=
ENV TRUSTED_PROXIES=

COPY <<'EOF' /etc/caddy/Caddyfile
{
  servers {
    import /etc/caddy/trusted_proxies.caddy
  }
}

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

COPY --chmod=755 <<'EOF' /usr/local/bin/docker-entrypoint.sh
#!/bin/sh
set -eu

TRUSTED_PROXIES_FILE="/etc/caddy/trusted_proxies.caddy"
# 将逗号、制表符、换行归一化为空格并裁剪首尾空白，兼容单值、多 CIDR（空格或逗号分隔）及空值
normalized_proxies="$(printf '%s' "${TRUSTED_PROXIES:-}" | tr ',\t\r\n' '    ' | sed 's/^ *//; s/ *$//; s/  */ /g')"

if [ -n "$normalized_proxies" ]; then
  # Caddyfile 中 {$ENV} 只会被当作单个 token，且 trusted_proxies static 不允许空参数，
  # 因此在容器启动时按环境变量生成配置片段供主 Caddyfile import，并启用严格从右向左解析。
  printf 'trusted_proxies static %s\ntrusted_proxies_strict\n' "$normalized_proxies" > "$TRUSTED_PROXIES_FILE"
else
  : > "$TRUSTED_PROXIES_FILE"
fi

exec "$@"
EOF

RUN : > /etc/caddy/trusted_proxies.caddy

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
