.PHONY: test lookbook install docs lint-fix

install:
	bundle install
	cd lookbook && bundle install

docs:
	cd lookbook
	bin/dev

lint-fix:
	bundle exec standardrb --fix

test:
	 bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

release:
	$(if $(call equals,0,$(shell git diff-index --quiet HEAD; echo $$?)),, \
        $(error There are uncomitted changes. Aborting$?) \
    )
	sh -c 'rm -rf app/assets/vendor/*'
	touch app/assets/vendor/.keep
	NODE_ENV=production npm run prod:build:js
	NODE_ENV=production npm run prod:build:css
	git commit -am "Build new release assets"
	gem bump -t
	gem release -p -g

%:
	@:
