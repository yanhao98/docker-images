#!/bin/bash

# 遇到错误即刻退出，禁止未定义变量
set -euo pipefail

# 校验必需环境变量
if [ -z "${GIT_REPO_URL:-}" ]; then
  echo "❌ 环境变量 GIT_REPO_URL 未设置！请提供 Git 仓库地址。"
  echo "示例: -e GIT_REPO_URL=https://github.com/user/repo.git"
  exit 1
fi

# 默认拉取 main 分支
GIT_BRANCH=${GIT_BRANCH:-main}

# 关闭 git 交互输入，避免容器内卡住等待用户名/密码
export GIT_TERMINAL_PROMPT=0

# Git 网络超时参数（秒）
GIT_CONNECT_TIMEOUT=${GIT_CONNECT_TIMEOUT:-15}
GIT_FETCH_TIMEOUT=${GIT_FETCH_TIMEOUT:-30}
GIT_FETCH_RETRIES=${GIT_FETCH_RETRIES:-2}
GIT_LFS_PULL_TIMEOUT=${GIT_LFS_PULL_TIMEOUT:-120}

mask_repo_url() {
  # 屏蔽 URL 中的敏感信息（如 https://user:token@host）
  echo "$1" | sed -E 's#(https?://)[^/@]+@#\1***@#'
}

run_git_fetch() {
  local attempt=1
  while [ "$attempt" -le "$GIT_FETCH_RETRIES" ]; do
    echo "🔎 Git 拉取尝试 ${attempt}/${GIT_FETCH_RETRIES}..."

    if command -v timeout >/dev/null 2>&1; then
      if timeout "${GIT_FETCH_TIMEOUT}s" git -c http.connectTimeout="$GIT_CONNECT_TIMEOUT" -c http.version=HTTP/1.1 fetch --depth 1 origin "$GIT_BRANCH"; then
        return 0
      fi
    else
      if git -c http.connectTimeout="$GIT_CONNECT_TIMEOUT" -c http.version=HTTP/1.1 fetch --depth 1 origin "$GIT_BRANCH"; then
        return 0
      fi
    fi

    if [ "$attempt" -lt "$GIT_FETCH_RETRIES" ]; then
      echo "⚠️ Git 拉取失败，3 秒后重试..."
      sleep 3
    fi

    attempt=$((attempt + 1))
  done

  echo "❌ Git 拉取失败，已达到最大重试次数 (${GIT_FETCH_RETRIES})。"
  return 1
}

cleanup_git_locks() {
  # 容器异常退出后可能遗留 lock 文件，导致后续 fetch/reset 失败
  if [ -d ".git" ]; then
    rm -f .git/index.lock .git/shallow.lock .git/FETCH_HEAD.lock
  fi
}

setup_git_lfs() {
  if command -v git-lfs >/dev/null 2>&1; then
    git lfs install --local
  fi
}

run_git_lfs_pull() {
  if ! command -v git-lfs >/dev/null 2>&1; then
    echo "⚠️ 未安装 git-lfs，跳过 LFS 文件拉取。"
    return 0
  fi

  echo "========================================"
  echo "📦 拉取 Git LFS 文件"
  echo "========================================"

  if command -v timeout >/dev/null 2>&1; then
    timeout "${GIT_LFS_PULL_TIMEOUT}s" git lfs pull origin "$GIT_BRANCH"
  else
    git lfs pull origin "$GIT_BRANCH"
  fi
}

echo "========================================"
echo "📦 初始化项目仓库"
echo "========================================"

MASKED_REPO_URL=$(mask_repo_url "$GIT_REPO_URL")
cleanup_git_locks

if [ ! -d ".git" ]; then
  echo "🔄 正在初始化 Git 仓库并拉取 $MASKED_REPO_URL (分支: $GIT_BRANCH)..."
  git init -b "$GIT_BRANCH"
  git remote add origin "$GIT_REPO_URL"
  setup_git_lfs
  run_git_fetch
  git checkout -B "$GIT_BRANCH" FETCH_HEAD
  git reset --hard FETCH_HEAD
  run_git_lfs_pull
else
  echo "🔄 发现已存在的 Git 仓库，正在拉取最新代码..."
  git remote set-url origin "$GIT_REPO_URL"
  setup_git_lfs
  run_git_fetch
  git checkout -B "$GIT_BRANCH" FETCH_HEAD
  git reset --hard FETCH_HEAD
  run_git_lfs_pull
fi

echo "========================================"
echo "📦 安装依赖 (bun install)"
echo "========================================"
bun install

echo "========================================"
echo "🚀 启动应用"
echo "========================================"

# 执行传入的命令或默认执行 bun run src/index.ts
if [ $# -eq 0 ]; then
  exec bun run src/index.ts
else
  exec "$@"
fi
