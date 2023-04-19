FROM sonarqube:7.1

USER root  
RUN chown -R sonarqube:sonarqube /opt/sonarqube
RUN apt-get update  
RUN apt-get install -y vim wget  
RUN chown -R sonarqube:sonarqube /opt/sonarqube

# Install sonarqube scanner.  
WORKDIR /usr/src 
RUN chown -R sonarqube:sonarqube /opt/sonarqube
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492.zip && \
    unzip sonar-scanner-cli-3.3.0.1492.zip && mv sonar-scanner-3.3.0.1492/ /usr/lib/sonar-scanner
    
RUN chown -R sonarqube:sonarqube /opt/sonarqube
# Create symbolic link.  
RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner  
ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner  

RUN chown -R sonarqube:sonarqube /opt/sonarqube
RUN mkdir /home/.sonar
RUN chown -R sonarqube:sonarqube /opt/sonarqube
RUN chmod 777 /home/.sonar
RUN chown -R sonarqube:sonarqube /opt/sonarqube
ENV SONAR_USER_HOME=/home/.sonar

RUN chown -R sonarqube:sonarqube /opt/sonarqube
# Switch back to the sonarqube environment.  
WORKDIR $SONARQUBE_HOME  
USER sonarqube  
