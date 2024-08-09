FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget ansible procps curl && \
    apt-get clean

# Install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz -O /tmp/tomcat.tar.gz && \
    mkdir /opt/tomcat && \
    tar xzf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz

# Set up environment variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy necessary files
COPY tomcat_deploy.yml /data/tomcat_deploy.yml
COPY inventory.ini /data/inventory.ini 
COPY tomcat_test.sh /data/tomcat_test.sh
COPY tomcat_deploy.sh /data/tomcat_deploy.sh
COPY sample.war /opt/tomcat/webapps/sample.war
COPY sample /opt/tomcat/webapps/sample

# Make scripts executable
RUN chmod +x /data/tomcat_test.sh /data/tomcat_deploy.sh

# Set working directory
WORKDIR /data

ENV CATALINA_BASE /opt/tomcat

# Default command to start Tomcat
CMD ["catalina.sh", "run"]

