# Stage 1: Builder
FROM node:17-alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 4000
ENV PATH /app/node_modules/.bin:$PATH
RUN npm run build

# Stage 2: Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf