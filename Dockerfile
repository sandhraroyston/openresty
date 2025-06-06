FROM openresty/openresty:alpine

COPY app/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY app/hello.lua /usr/local/openresty/nginx/lua/hello.lua

EXPOSE 80

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
