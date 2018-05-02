REGISTRY_URL=273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot

aws-login:
	aws ecr get-login --no-include-email --region us-west-2 | sh

build-ui-docker-container: aws-login
	docker build --rm -t $(REGISTRY_URL):ui-latest -f ./ui/.docker/Dockerfile ./ui/.docker
	docker push $(REGISTRY_URL):ui-latest

build-db-docker-container: aws-login
	docker build --rm -t $(REGISTRY_URL):db-latest -f ./db/.docker/Dockerfile ./db/.docker
	docker push $(REGISTRY_URL):db-latest

mount-ui-docker-container:
	docker run --rm -ti -p 3000:3000 -p 35729:35729 -v `pwd`/ui/my-app:/code -w /code $(REGISTRY_URL):ui-latest sh

up-dev:
	docker-compose -f .docker-compose/fullstack.yaml up