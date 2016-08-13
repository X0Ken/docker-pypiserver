FROM python:2.7-alpine

RUN pip install pypiserver passlib
RUN apk add --no-cache bash

COPY docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh
COPY htpasswd.txt /root/htpasswd.txt

VOLUME /root/packages
EXPOSE 8000

ENTRYPOINT ["/root/docker-entrypoint.sh"]
CMD ["pypiserver"]