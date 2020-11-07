setup: build

build:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml build

rebuild:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml build --no-cache

up:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml up

app-up:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml up app

batch-up:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml up batch

redis-up:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml up -d redis

down:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml down

test:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml run --rm app rspec

app-shell:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml run --rm app /bin/sh

batch-shell:
	docker-compose -f ./docker-compose.yml -f ./docker-compose.local.yml run --rm batch /bin/sh

.PHONY: setup build rebuild up app-up batch-up redis-up down test app-shell batch-shell
