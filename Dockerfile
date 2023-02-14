FROM --platform=$BUILDPLATFORM debian:11-slim AS build

ARG TARGETOS
ARG TARGETARCH

ARG TF_VERSION=1.3.8

RUN apt update && apt upgrade
RUN apt install -y wget curl unzip jq sudo

RUN curl -q https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${TARGETOS}_${TARGETARCH}.zip -o terraform.zip && \
    unzip -qq terraform.zip && \
    mv terraform /usr/bin/terraform && \
    chmod +x /usr/bin/terraform && \
    rm -f terraform_*.zip*

ADD https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_${TARGETOS}_${TARGETARCH} /usr/bin/terragrunt

RUN if [ "$TARGETARCH" = "amd64" ]; then \
    curl -q "https://awscli.amazonaws.com/awscli-exe-${TARGETOS}-x86_64.zip" -o "awscliv2.zip"; \
  else \
    curl -q "https://awscli.amazonaws.com/awscli-exe-${TARGETOS}-aarch64.zip" -o "awscliv2.zip"; \
  fi

ADD https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-${TARGETOS}-${TARGETARCH}${EXTENSION} /usr/bin/aws-vault

RUN unzip -qq awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip ./aws/

RUN chmod +x /usr/bin/terraform /usr/bin/terragrunt /usr/bin/aws-vault

RUN useradd --no-create-home --shell /bin/bash provision
USER provision
