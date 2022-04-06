CONTAINER_NAME=cse2431

compose: 
	docker-compose up --build -d
	docker-compose exec cse2431 bash

dev: build-dev run-dev

build-dev:
	docker build --target dev -t $(CONTAINER_NAME)-dev .

run-dev:
	docker run -it --volume $(shell pwd):/code $(CONTAINER_NAME)-dev

prod: build-prod run-prod

build-prod:
	docker build --target prod -t $(CONTAINER_NAME)-prod .

run-prod:
	docker run -it --volume $(shell pwd):/code $(CONTAINER_NAME)-prod 

clean:
	docker rmi $(shell docker images --filter "dangling=true" -q --no-trunc) --force
	docker image prune --filter="dangling=true" --force
