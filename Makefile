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

%:
	@:
