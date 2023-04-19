FROM sonarqube:7.1
USER root
# Install packages.  
RUN apt-get update  
RUN apt-get install -y vim wget

# Install sonarqube scanner.  
#WORKDIR /usr/src 

#RUN chown -R sonarqube $SONARQUBE_HOME
# install sonarscanner
RUN echo 1
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492.zip && \
    unzip sonar-scanner-cli-3.3.0.1492.zip && mv sonar-scanner-3.3.0.1492/ /usr/lib/sonar-scanner

RUN echo 2
# Create symbolic link.  
RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner  
ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner  

RUN echo 3
RUN mkdir /home/.sonar
RUN chmod 777 /home/.sonar
ENV SONAR_USER_HOME=/home/.sonar

RUN echo 4
# Switch back to the sonarqube environment.  
WORKDIR $SONARQUBE_HOME  
USER sonarqube  

