#!/bin/bash
docker-compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
  --email freiweg89@gmail.de \
  -d registry.monarch.de \
  --rsa-key-size 4096 \
  --agree-tos \
  --force-renewal" certbot

 echo "add the following to the crontab to renew the certificates automatically once a month"
 echo "30 3 5 * * /usr/bin/docker-compose -f /root/lightweight_dockerregistry/docker-compose.yml run --rm certbot renew"
 




