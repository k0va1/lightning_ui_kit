.PHONY: test lookbook

install:
	bundle install
	cd lookbook && bundle install

docs:
	cd lookbook
	bin/dev

test:
	 bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

%:
	@:
