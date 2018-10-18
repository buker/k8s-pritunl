IMAGE_NAME ?= buker/k8s-pritunl
TAG ?= 0.1
IMAGE = $(IMAGE_NAME):$(TAG)
build:
	docker build -t $(IMAGE) .
	echo 'Image builded'

clean:
	docker rmi $(IMAGE) || true
	echo 'Image removed'

push: build
	docker push $(IMAGE)
	echo 'Image pushed'

all: build push clean
