aws-login:
	aws ecr get-login --no-include-email --region us-west-2 | sh

build-ui-docker-container: aws-login
	docker build --rm -t 273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot:ui-latest -f ./ui/.docker/Dockerfile ./ui/.docker
	docker push 273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot:ui-latest

mount-ui-docker-container:
	docker run --rm -ti -p 3000:3000 -p 35729:35729 -v `pwd`/ui/my-app:/code -w /code 273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot:ui-latest sh

up-dev:
	docker run --rm -ti -p 3000:3000 -p 35729:35729 -v `pwd`/ui/my-app:/code -w /code 273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot:ui-latest yarn start