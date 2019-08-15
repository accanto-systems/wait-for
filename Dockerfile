FROM alpine:latest

COPY wait-for.sh /
RUN chmod +x /wait-for.sh

RUN apk add --update bash curl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/wait-for.sh"]
