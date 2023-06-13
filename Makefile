build:
	@docker-compose -f docker-compose.yml --env-file .env build

start:
	@docker-compose -f docker-compose.yml --env-file .env up -d