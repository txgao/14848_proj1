FROM sonarqube:latest

# Switch to root user to be able to install packages.  
USER root  

# Install packages.  
RUN apt-get update  
RUN apt-get install -y vim wget  

# Install sonarqube scanner.  
WORKDIR /usr/src  

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip  

RUN unzip sonar-scanner-cli-4.2.0.1873-linux.zip  
RUN rm sonar-scanner-cli-4.2.0.1873-linux.zip  
RUN mv sonar-scanner-4.2.0.1873-linux /usr/lib/sonar-scanner  

# Create symbolic link.  
RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner  
ENV SONAR_RUNNER_HOME=/usr/lib/sonar-scanner  

RUN mkdir /home/.sonar
RUN chmod 777 /home/.sonar
ENV SONAR_USER_HOME=/home/.sonar

# Switch back to the sonarqube environment.  
WORKDIR $SONARQUBE_HOME  
USER sonarqube  
