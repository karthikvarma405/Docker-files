# version 0.1
FROM ubuntu:16.04
MAINTAINER karthik varma "karthikvarma.p@quantela.com"

ENV TOMCAT_VERSION 9.0.6

RUN apt-get update
RUN apt-get install -y software-properties-common vim net-tools curl 

# Install JDK 8
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer wget unzip tar && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Get Tomcat
RUN wget http://apache.mirrors.ionfish.org/tomcat/tomcat-9/v9.0.6/bin/apache-tomcat-9.0.6.tar.gz && \
tar xzvf apache-tomcat-9.0.6.tar.gz -C /opt && mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Enable SSL

EXPOSE 8080 8443

WORKDIR /opt/tomcat
RUN touch /opt/tomcat/logs/catalina.out
COPY Entry-point.sh /usr/local/bin/Entry-point.sh
RUN chmod +x /usr/local/bin/Entry-point.sh
#COPY server.xml /opt/tomcat/conf/server.xml
#COPY atlantis-analytics.war /opt/tomcat/webapps
ENTRYPOINT ["Entry-point.sh"]
CMD /opt/tomcat/bin/startup.sh



