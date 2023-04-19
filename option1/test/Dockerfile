FROM sonarqube:7.1

WORKDIR $SONARQUBE_HOME
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492.zip && \
    unzip sonar-scanner-cli-3.3.0.1492.zip && mv sonar-scanner-3.3.0.1492/ /usr/lib/sonar-scanner
    
# Create symbolic link.  
RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner  
ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner  
 
RUN mkdir /home/.sonar
RUN chmod 777 /home/.sonar
ENV SONAR_USER_HOME=/home/.sonar
 
WORKDIR $SONARQUBE_HOME  
USER sonarqube  
