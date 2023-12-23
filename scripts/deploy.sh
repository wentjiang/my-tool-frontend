#!/bin/bash
set -eufo pipefail

cd "$(dirname "$0")/.."

. scripts/config.sh

echo "部署到远程服务器"

echo "停止docker容器"
ssh root@"${REMOTE_SERVER}" "docker stop ${CONTAINER_NAME} || true"
echo "拉取最新的镜像"
ssh root@"${REMOTE_SERVER}" "docker pull ${DOCKER_IMAGE_NAME}:latest"
echo "启动新版本的镜像"
ssh root@"${REMOTE_SERVER}" "docker run --rm -p 5002:80 --name my-tool-frontend -e VITE_BACKEND_URL=http://localhost:5001/my-tool/v1-0/ ${DOCKER_IMAGE_NAME}:latest"

echo "部署完成!"
