#!/bin/sh

MEDIAWIKI_API_URL="${MEDIAWIKI_API_URL:-http://localhost/w/api.php}"
MEDIAWIKI_DOMAIN="${MEDIAWIKI_DOMAIN:-localhost}"
MEDIAWIKI_PREFIX="${MEDIAWIKI_PREFIX:-localhost}"
NUM_WORKERS="${NUM_WORKERS:-4}"

cat /usr/local/lib/node_modules/parsoid/config.example.yaml \
    | sed -e "s@uri: 'http://localhost/w/api.php'@uri: '${MEDIAWIKI_API_URL}'@" \
    | sed -e "s@domain: 'localhost'@domain: '${MEDIAWIKI_DOMAIN}'@" \
    | sed -e "s@#metrics:@metrics:@" \
    | sed -e "s@#\(\s*type: log\)@\1@" \
    > /config.yaml
echo "num_workers: $NUM_WORKERS" >> /config.yaml

exec "$@"
