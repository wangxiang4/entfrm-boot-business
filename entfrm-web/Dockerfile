FROM moxm/java:1.8-full

RUN mkdir -p /entfrm-web

WORKDIR /entfrm-web

ARG JAR_FILE=target/entfrm-web.jar

COPY ${JAR_FILE} app.jar

EXPOSE 8888

ENV TZ=Asia/Shanghai JAVA_OPTS="-Xms128m -Xmx256m -Djava.security.egd=file:/dev/./urandom"

CMD java -jar app.jar $JAVA_OPTS
