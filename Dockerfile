FROM alpine:latest

ENV CONSUL_TEMPLATE_VERSION 0.14.0

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN apk -U add zip bash && \
    unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template &&\
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mkdir -p /consul-template /consul-template/config.d /consul-template/templates && \
    rm -rf /docker && \
    apk del zip && \
    rm -rf /var/cache/apk/* && \
    ln -sfn /lib /lib64 && \
    ln -sfn /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

COPY watchdog.sh /usr/local/bin/watchdog

RUN chmod +x /usr/local/bin/watchdog

CMD [ "/usr/local/bin/watchdog"]
