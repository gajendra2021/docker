FROM alpine
FROM python:3.6

RUN apk add --update curl python bash &&  rm -rf /var/cache/apk/*
ENV HOME /
#RUN curl https://sdk.cloud.google.com | bash
ARG CLOUD_SDK_VERSION=151.0.1
ARG SHA256SUM=26b84898bc7834664f02b713fd73c7787e62827d2d486f58314cdf1f6f6c56bb
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz
RUN echo "${SHA256SUM}  google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" > google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256
RUN sha256sum -c google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256
RUN tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz 
ENV PATH /google-cloud-sdk/bin:$PATH
RUN gcloud config set core/disable_usage_reporting true
RUN gcloud config set component_manager/disable_update_check true
VOLUME ["/.config"]

CMD ["python3","app.py", "tactile-vehicle-294612", "cluster-2"]
