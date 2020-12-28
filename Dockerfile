FROM openjdk:8-jre-alpine

ENV APPLICATION_USER ktor
RUN adduser -D -g '' $APPLICATION_USER

RUN mkdir /app
RUN chown -R $APPLICATION_USER /app

USER $APPLICATION_USER
RUN mvn clean package

COPY ./build/libs/my-application.jar /app/my-application.jar
WORKDIR /app

CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "my-application.jar"]


# FROM openjdk:8-jre-alpine

# MAINTAINER delxie "se_tangqiu@hetaozs.com"

# # 环境变量
# ENV APP_NAME ktor-nacos

# #使用 WORKDIR 指令可以来指定工作目录（或者称为当前目录），以后各层的当前目录就被改为指定的目录，如该目录不存在，WORKDIR 会帮你建立目录。
# WORKDIR /webapps

# #创建日志目录链接
# RUN mkdir /logs && \
# 		mkdir -p /dockerv/private && \
# 		ln -s /logs /dockerv/private/webapplogs

# #将工程WAR包加到webapps目录，并命名为ROOT.war
# ADD ${APP_NAME} app.jar

# EXPOSE 8080

# ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]
