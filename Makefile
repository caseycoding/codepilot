REGISTRY_URL=273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot

aws-login:
	aws ecr get-login --no-include-email --region us-west-2 | sh

build-ui-docker-container: aws-login
	docker build --rm -t $(REGISTRY_URL):ui-latest -f ./ui/.docker/Dockerfile ./ui/.docker
	docker push $(REGISTRY_URL):ui-latest

build-db-docker-container: aws-login
	docker build --rm -t $(REGISTRY_URL):db-latest -f ./db/.docker/Dockerfile ./db/.docker
	docker push $(REGISTRY_URL):db-latest

build-lambda-docker-container: aws-login
	docker build --rm -t $(REGISTRY_URL):lambda-latest -f ./lambda/.docker/Dockerfile ./lambda/.docker
	docker push $(REGISTRY_URL):lambda-latest

mount-ui-docker-container:
	docker run --rm -ti -p 3000:3000 -p 35729:35729 -v `pwd`/ui/my-app:/code -w /code $(REGISTRY_URL):ui-latest sh

mount-lambda-docker-container:
	docker run --rm -ti -v `pwd`/lambda/codepylot:/code -w /code $(REGISTRY_URL):lambda-latest sh

up-dev:
	docker-compose -f .docker-compose/fullstack.yaml up

up-lambda:
	docker-compose -f .docker-compose/lambda.yaml up

deploy-lambda:
	docker run \
	--rm -ti \
	-v `pwd`/lambda/codepylot:/code \
	-v $$HOME/.aws:/root/.aws \
	-w /code \
	$(REGISTRY_URL):lambda-latest \
	sh /code/deploy.sh