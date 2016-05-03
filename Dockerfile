FROM alpine:latest

ENV CONSUL_TEMPLATE_VERSION 0.14.0
ENV DOCKER_VERSION 1.11.1

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
ADD https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz /

RUN apk -U add zip && \
    unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template &&\
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mkdir -p /consul-template /consul-template/config.d /consul-template/templates && \
    tar xvzf /docker-${DOCKER_VERSION}.tgz && \
    mv /docker/* /usr/local/bin/ && \
    rm /docker-${DOCKER_VERSION}.tgz && \
    rm -rf /docker && \
    apk del zip && \
    rm -rf /var/cache/apk/*

CMD [ "/usr/local/bin/consul-template"]
