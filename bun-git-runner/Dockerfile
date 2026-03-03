FROM oven/bun:1

WORKDIR /usr/src/app

# 安装 git 和 ca-certificates（用于安全克隆仓库），安装完成后清理 apt 缓存以缩减镜像体积
RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000/tcp

# 启动入口点，执行运行时仓库拉取与依赖安装
ENTRYPOINT ["/entrypoint.sh"]
