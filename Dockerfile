FROM maven:3.8.5-openjdk-17 AS build
ENV MAVEN_OPTS="-Xmx256m"
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk17
RUN sed -i 's/port="8005"/port="-1"/g' /usr/local/tomcat/conf/server.xml
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
ENV CATALINA_OPTS="-Xms128m -Xmx350m"
CMD ["catalina.sh", "run"]
