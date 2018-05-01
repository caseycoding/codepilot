aws-login:
	aws ecr get-login --no-include-email --region us-west-2 | sh

build-ui-docker-container: aws-login
	docker build --rm -t 273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot:ui-latest -f ./ui/.docker/Dockerfile ./ui/.docker
	docker push 273325000860.dkr.ecr.us-west-2.amazonaws.com/codepilot:ui-latest