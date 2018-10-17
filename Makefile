IMAGE_NAME=buker/k8s-pritunl

build:
	docker build -t $(IMAGE_NAME) .
	echo 'Image builded'

clean:
	docker rmi $(IMAGE_NAME) || true
	echo 'Image removed'

push:
	docker push $(IMAGE_NAME)
	echo 'Image pushed'

all: build push clean
