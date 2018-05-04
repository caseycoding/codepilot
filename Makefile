REGISTRY_URL=273325000860.dkr.ecr.us-west-2.amazonaws.com/casey-demo

aws-login:
	aws ecr get-login --no-include-email --region us-west-2 | sh

build-api-docker-image: aws-login
	docker build --rm -t $(REGISTRY_URL):api-latest -f ./api/.docker/Dockerfile ./api
	docker push $(REGISTRY_URL):api-latest

build-api-docker-release-image: aws-login
	docker build --rm -t $(REGISTRY_URL):api-release -f ./api/.docker/Release.Dockerfile ./api
	docker push $(REGISTRY_URL):api-release

api-up: aws-login
	docker-compose -f `pwd`/.docker-compose/api.yml up