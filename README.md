# Docker Terraform, Terragrunt & AWS

[![Docker Pulls](https://badgen.net/docker/pulls/d4kine/terragrunt-aws?icon=docker&label=pulls)](https://hub.docker.com/r/d4kine/terragrunt-aws/)
[![Docker Stars](https://badgen.net/docker/stars/d4kine/terragrunt-aws?icon=docker&label=stars)](https://hub.docker.com/r/d4kine/terragrunt-aws/)
[![Docker Image Size](https://badgen.net/docker/size/d4kine/terragrunt-aws?icon=docker&label=image%20size)](https://hub.docker.com/r/d4kine/terragrunt-aws/)

Container to provision infrastructure components using Terraform, Terragrunt and AWS (CLI v2 & Vault) based on alpine. This Image also contains `jq` for CI/CD-pipeline purposes.

## Getting started

```sh
docker run --name terragrunt-aws d4kine/terragrunt-aws
```

If you plan to use this container with an existing Terraform or Terragrunt script, you need to mount everything necessary to it and setup env vars:

```sh
docker run --name terragrunt-aws \
  -e AWS_ACCESS_KEY_ID="" \
  -e AWS_SECRET_ACCESS_KEY="" \
  -e AWS_DEFAULT_REGION="" \
  -e TERRAFORM_BACKEND_S3_BUCKET_NAME="" \
  -e TERRAFORM_BACKEND_S3_DYNAMODB_TABLE="" \
  -v "./localrepo:/provision"
  d4kine/terragrunt-aws /bin/bash
```

### Setup Environment Variables
Setup the folliwing environment variablen, for everything to work properly:

- `AWS_ACCESS_KEY_ID`: Client-Key to use the AWS CLI v2
- `AWS_SECRET_ACCESS_KEY`: Secret for the Client-Key
- `AWS_DEFAULT_REGION`: Default AWS region to use
- `TERRAFORM_BACKEND_S3_BUCKET_NAME`: Name of the S3-bucket to store the state file
- `TERRAFORM_BACKEND_S3_DYNAMODB_TABLE`: Name of the DynamoDB-Table to store the lock
