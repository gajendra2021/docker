USER root

# Install Docker from official repo
RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update -qq && \
    apt-get install -qqy docker-ce && \
    usermod -aG docker jenkins && \
    chown -R jenkins:jenkins $JENKINS_HOME/

USER jenkins

VOLUME [$JENKINS_HOME, "/var/run/docker.sock"]

FROM ubuntu 14.04
FROM python:3.6

RUN mkdir /usr/src/app/


COPY . /usr/src/app/

WORKDIR /usr/src/app



sudo apt-get update -qq
 
sudo apt-get -qq -y install podman
RUN pip install -r requirements.txt 
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

CMD ["python3","app.py", "tactile-vehicle-294612","cluster-1"]
