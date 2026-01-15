.PHONY: test lookbook install docs lint-fix start release check_clean

install:
	bundle install
	npm install
	cd lookbook && bundle install

docs:
	cd lookbook
	bin/dev

start:
	rm -rf app/assets/vendor/lightning_ui_kit.*
	overmind start -f Procfile.dev

lint-fix:
	bundle exec standardrb --fix

test:
	 bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

check_clean:
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "❌ Uncommitted changes found. Please commit or stash them first."; \
		exit 1; \
	fi

kamal:
	env $$(cat .env | xargs) kamal $(filter-out $@,$(MAKECMDGOALS))

deploy:
	env $$(cat .env | xargs) kamal  deploy

build:
	sh -c 'rm -rf app/assets/vendor/lightning_ui_kit.*'
	@echo "Building assets..."
	@NODE_ENV=production npm run prod:build:js
	@NODE_ENV=production npm run prod:build:css

release: check_clean
	sh -c 'rm -rf app/assets/vendor/lightning_ui_kit.*'
	NODE_ENV=production npm run prod:build:js
	NODE_ENV=production npm run prod:build:css
	git add .
	git commit -am "Build new release assets"
	gem bump -t -v $(filter-out $@,$(MAKECMDGOALS))
	gem release -p -g

%:
	@:
