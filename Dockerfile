
FROM ubuntu
FROM python:3.6

RUN mkdir /usr/src/app/

ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
COPY . /usr/src/app/

WORKDIR /usr/src/app

RUN apt-get update && apt-get -y install sudo


 

RUN pip install -r requirements.txt 
ENV CLOUD_SDK_REPO="cloud-sdk-stretch"
RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-sdk

# Setup Google Service Account
RUN gcloud auth activate-service-account --key-file=${tactile-vehicle-294612	}
    
        
ENV PATH $PATH:/root/google-cloud-sdk/bin


CMD ["python3","app.py", "tactile-vehicle-294612", "cluster-2"]
