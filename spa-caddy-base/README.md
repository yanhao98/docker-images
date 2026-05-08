# spa-caddy-base

一个用于部署前端 SPA 的 Caddy 基础镜像。

镜像内置 Caddy 配置：

- `/API/*` 转发到后端服务，默认目标是 `api:3000`
- 转发时不保留 `/API` 前缀，例如 `/API/users` 会转发为 `/users`
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

通过 `API_PROXY_TARGET` 覆盖默认后端地址：

```bash
docker run --rm -p 8080:80 \
  -e API_PROXY_TARGET=backend:3000 \
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

  api:
    image: your-api-image
```

## 内置 Caddy 行为

```caddyfile
:80 {
  handle_path /API/* {
    reverse_proxy {$API_PROXY_TARGET}
  }

  handle {
    root * /usr/share/caddy
    try_files {path} /index.html
    file_server
  }
}
```
