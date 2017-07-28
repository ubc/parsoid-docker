FROM node:8.2-alpine

ENV PARSOID_VERSION v0.7.1

EXPOSE 8000

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN apk add --no-cache git \
    && npm install -g --only=production parsoid@${PARSOID_VERSION} \
    && npm cache clean --force \
    && rm -rf /tmp/npm* /root/.node* /root/.npm

CMD ["node", "/usr/local/lib/node_modules/parsoid/bin/server.js", "--config=/config.yaml"]
