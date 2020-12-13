FROM ubuntu
FROM python:3.6

RUN mkdir /usr/src/app/

ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
COPY . /usr/src/app/

WORKDIR /usr/src/app

RUN apt-get update && apt-get -y install sudo


 

RUN pip install -r requirements.txt 
RUN apt-get -qqy update && apt-get install -qqy \
        curl \
        gcc \
        python-dev \
        python-setuptools \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \
        gnupg \
    && easy_install -U pip && \
    pip install -U crcmod   && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
    gcloud --version
    gcloud config set disable_usage_reporting true

CMD ["python3","app.py", "tactile-vehicle-294612", "cluster-2"]
