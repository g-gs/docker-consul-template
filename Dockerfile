FROM gliderlabs/alpine
MAINTAINER Gustavo Gonzalez

ENV CONSUL_TEMPLATE_VERSION 0.14.0
ENV DOCKER_HOST unix:///tmp/docker.sock

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_SHA256SUMS /tmp/
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /tmp/
ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /bin/docker

RUN cd /tmp && \ 
    sha256sum -c consul-template_${CONSUL_TEMPLATE_VERSION}_SHA256SUMS 2>&1 | grep OK && \
    unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \ 
    mv consul-template /bin/consul-template && \
    rm -rf /tmp && \
    chmod +x /bin/docker && \
    apk --update add curl bash

ENTRYPOINT ["/bin/consul-template"]
