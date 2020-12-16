FROM python:3.6

RUN mkdir /usr/src/app/

COPY . /usr/src/app/

WORKDIR /usr/src/app

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh


CMD ["python3","app.py", "tactile-vehicle-294612","cluster-2"]
