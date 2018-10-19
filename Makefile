IMAGE_NAME ?= buker/k8s-pritunl
TAG ?= 0.1
IMAGE = $(IMAGE_NAME):$(TAG)
MONGODB_USER ?= user
MONGODB_PASS ?= pass
MONGODB_HOST ?= mongodb
PRITUNL_MONGODB_URI=mongodb://$(MONGODB_USER):$(MONGODB_PASS)@$(MONGODB_HOST):27017/pritunl
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

up:
	echo $(PRITUNL_MONGODB_URI);
	PRITUNL_MANGODB_URI=$(PRITUNL_MONGODB_URI) TAG=$(TAG) MONGODB_USER=$(MONGODB_USER) MONGODB_PASS=$(MONGODB_PASS) docker-compose up
