.PHONY: test lookbook install docs lint-fix

install:
	bundle install
	cd lookbook && bundle install

docs:
	cd lookbook
	bin/dev

start:
	cd lookbook
	rm -rf app/assets/vendor/lightning_ui_kit.*
	bin/dev

lint-fix:
	bundle exec standardrb --fix

test:
	 bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

check_clean:
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "❌ Uncommitted changes found. Please commit or stash them first."; \
		exit 1; \
	fi

release: check_clean
	sh -c 'rm -rf app/assets/vendor/*'
	touch app/assets/vendor/.keep
	NODE_ENV=production npm run prod:build:js
	NODE_ENV=production npm run prod:build:css
	git add .
	git commit -am "Build new release assets"
	gem bump -t
	gem release -p -g

%:
	@:
