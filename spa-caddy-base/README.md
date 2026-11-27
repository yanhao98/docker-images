# spa-caddy-base

一个用于部署前端 SPA 的 Caddy 基础镜像。

镜像内置 Caddy 配置：

- `${API_PROXY_ROUTE_PREFIX}/*` 转发到后端服务，默认路由前缀是 `/API`，默认目标是 `api:3000`
- 转发时不保留 `API_PROXY_ROUTE_PREFIX` 前缀，例如默认配置下 `/API/users` 会转发为 `/users`
- 可通过 `API_PROXY_PATH_PREFIX` 给后端请求追加路径前缀，例如设为 `/bridge/remote` 后 `/API/users` 会转发为 `/bridge/remote/users`
- 可通过 `TRUSTED_PROXIES` 配置可信上游反向代理（支持 `private_ranges`、单 IP/CIDR 或空格/逗号分隔的多个 CIDR），默认为空（不信任任何上游 `X-Forwarded-For`）
- 其他路径从 `/usr/share/caddy` 提供静态文件
- 未命中静态文件时回退到 `/index.html`，用于支持前端路由

## 使用方式

在你的前端项目中创建 `Dockerfile`：

```dockerfile
FROM yanhao98/spa-caddy-base:latest

COPY dist/ /usr/share/caddy/
```

构建并运行：

```bash
docker build -t my-spa .
docker run --rm -p 8080:80 my-spa
```

访问：

```text
http://localhost:8080
```

## 配置后端地址

通过 `API_PROXY_TARGET` 覆盖默认后端地址，通过 `API_PROXY_ROUTE_PREFIX` 覆盖前端 API 路由前缀：

```bash
docker run --rm -p 8080:80 \
  -e API_PROXY_TARGET=backend:3000 \
  -e API_PROXY_ROUTE_PREFIX=/API \
  my-spa
```

如果后端入口还有固定路径前缀，可以设置 `API_PROXY_PATH_PREFIX`：

```bash
docker run --rm -p 8080:80 \
  -e API_PROXY_TARGET=bridge-b:7102 \
  -e API_PROXY_PATH_PREFIX=/bridge/remote \
  my-spa
```

如果容器部署在另一层反向代理（例如外层 Caddy / Nginx）后面，可通过 `TRUSTED_PROXIES` 信任上游代理以透传真实客户端 IP（启动时自动启用 `trusted_proxies_strict`）：

```bash
# 信任单个上游代理 IP/网段（推荐最小权限）
docker run --rm -p 8080:80 \
  -e API_PROXY_TARGET=api:3000 \
  -e TRUSTED_PROXIES=172.28.0.11/32 \
  my-spa

# 或信任所有私有/Docker 内网段，也支持空格或逗号分隔多个 CIDR
docker run --rm -p 8080:80 \
  -e API_PROXY_TARGET=api:3000 \
  -e TRUSTED_PROXIES=private_ranges \
  my-spa
```

如果使用 `docker compose`，可以直接指向同一网络中的服务名：

```yaml
services:
  web:
    image: my-spa
    ports:
      - "8080:80"
    environment:
      API_PROXY_TARGET: api:3000
      API_PROXY_ROUTE_PREFIX: /API
      API_PROXY_PATH_PREFIX: ""
      # 如前面还有外层反向代理，按实际可信网段设置（如 private_ranges 或 172.28.0.0/16）
      TRUSTED_PROXIES: ""

  api:
    image: your-api-image
```

## 内置 Caddy 行为

```caddyfile
{
  servers {
    import /etc/caddy/trusted_proxies.caddy
  }
}

:80 {
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
```

当 `TRUSTED_PROXIES` 非空时，容器启动脚本会将其展开写入 `/etc/caddy/trusted_proxies.caddy`（例如 `trusted_proxies static 172.28.0.0/16 10.0.0.0/8` + `trusted_proxies_strict`）；为空时保持空文件，不信任上游传入的 `X-Forwarded-For`。
