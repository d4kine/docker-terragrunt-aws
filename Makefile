IMAGE_TAG := "d4kine/terragrunt-aws"
ARCH := linux/amd64,linux/arm64

build: ## build the image
	docker build . -t ${IMAGE_TAG}

buildx: ## build & push the image with docker buildx
	docker buildx build . --file=./Dockerfile \
		--platform=${ARCH} \
		--tag=${IMAGE_TAG} \
		--output type=image,push=true

run: ## run the current container and exit after leaving shell
	docker run --rm -it ${IMAGE_TAG} bash