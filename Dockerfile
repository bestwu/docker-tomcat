FROM registry.cn-hangzhou.aliyuncs.com/bestwu/java:jre8
MAINTAINER Peter Wu <piterwu@outlook.com>

ENV TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.5.9 \
    TOMCAT_HOME=/tomcat

WORKDIR /tmp

RUN apk upgrade --update && \
    apk add --update curl && \
    curl -jksSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /tmp -xf /tmp/apache-tomcat.tar && \
    mv   /tmp/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME} && \
    rm -rf ${TOMCAT_HOME}/webapps/* && \
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*

ENV CATALINA_HOME=/tomcat \
    PATH=/tomcat/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]