# 使用 Node.js 作为基础镜像
FROM node:18 as build-stage

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 文件，以便缓存 npm install 步骤
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 构建项目
RUN npm run build

# 使用 nginx 作为基础镜像
FROM nginx:alpine

# 将构建好的 Vue.js 项目复制到 nginx 的默认目录
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 暴露端口（nginx 默认为 80）
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]
