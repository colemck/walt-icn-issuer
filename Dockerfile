FROM node:14 as buildstage
COPY . /
RUN yarn install && yarn build
FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx --from=buildstage /dist/ /usr/share/nginx/html/
RUN find /usr/share/nginx/html -type d -exec chmod 755 {} +
