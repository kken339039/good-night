build:
	@docker-compose -f docker-compose.yml --env-file .env build

start:
	@docker-compose -f docker-compose.yml --env-file .env up -d

test:
	@docker-compose -f docker-compose.yml --env-file .env run web bundle exec rspec

db_create:
	@docker-compose -f docker-compose.yml --env-file .env run web bundle exec rails db:create

db_migrate:
	@docker-compose -f docker-compose.yml --env-file .env run web bundle exec rails db:migrate

db_rollback:
	@docker-compose -f docker-compose.yml --env-file .env run web bundle exec rails db:rollback
