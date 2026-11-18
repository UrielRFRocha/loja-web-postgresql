FROM tomcat:9.0-jdk21-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/loja-web-sessao.war /usr/local/tomcat/webapps/loja-web-sessao.war
