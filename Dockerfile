FROM alpine:latest

ENV TERRAFORM_VERSION=0.11.7
ENV TERRAFORM_SHA256SUM=6b8ce67647a59b2a3f70199c304abca0ddec0e49fd060944c26f666298e23418
ENV ORACLE_BARE_METAL_CLOUD=2.1.17

RUN apk add --update git curl openssh && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN apk add bash openssl && \
      wget https://github.com/oracle/terraform-provider-baremetal/releases/download/v${ORACLE_BARE_METAL_CLOUD}/linux_amd64.tar.gz && \
      mkdir /usr/local/oracle && \
      tar -C /usr/local/oracle -xzf linux_amd64.tar.gz && \
      mkdir -p ~/.terraform.d/plugins/ && \
      cp -r /usr/local/oracle/linux_amd64 ~/.terraform.d/plugins/ && \
      rm -rf /usr/local/linux_amd64.tar.gz

COPY install.sh /home/install.sh

WORKDIR /home



