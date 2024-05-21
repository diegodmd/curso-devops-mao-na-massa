#está um pouco diferente do original do curso;
#Explicação das mudanças:
#Imagem Base: Troquei openjdk:8-jdk-alpine por openjdk:11-jdk-slim para usar o JDK 11.
#Maven: Atualizei a versão do Maven para 3.6.3 e ajustei os comandos de instalação para usar apt-get em vez de apk, 
#já que a imagem slim do OpenJDK 11 usa Debian como base.
FROM openjdk:11-jdk-slim
RUN addgroup --system notes && adduser --system --ingroup notes notes
ENV MAVEN_VERSION 3.6.3
ENV MAVEN_HOME /usr/share/maven
ENV PATH $MAVEN_HOME/bin:$PATH
RUN apt-get update && apt-get install -y wget git && \
    wget https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/share && \
    ln -s /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz
WORKDIR /opt/note
RUN git clone https://github.com/callicoder/spring-boot-mysql-rest-api-tutorial.git /opt/note
RUN chown -R notes:notes /opt/note
USER notes
RUN mvn package -Dmaven.test.skip=true
ARG JAR_FILE=*.jar
RUN cp ./target/easy-notes-1.0.0.jar /opt/note/easy-note.jar
COPY application.properties application.properties
ENTRYPOINT ["java","-jar","/opt/note/easy-note.jar"]