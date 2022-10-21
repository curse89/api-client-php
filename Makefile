
run:
	@echo "==> Running app"
	@php-fpm

up:
	@docker-compose up

in:
	docker exec -it api_app sh
