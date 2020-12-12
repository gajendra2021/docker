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
