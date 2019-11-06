FROM golang:alpine

ENV TERRAFORM_VERSION=0.11.14
ENV VAULT_VERSION=1.0.3

RUN apk add --update git bash openssh py3-pip build-base python-dev libffi-dev openssl-dev python3 wget python3-dev

COPY requirements.txt .

RUN pip3 install -r requirements.txt

#RUN pip3 install awscli

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR /tmp/

RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d $GOPATH/bin/

RUN wget --quiet https://releases.hashicorp.com/vault/0.11.5/vault_0.11.5_linux_amd64.zip -O vault.zip && \
    unzip vault.zip -d $GOPATH/bin/

WORKDIR $GOPATH
ENTRYPOINT ["terraform"]
