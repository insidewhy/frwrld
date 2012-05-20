.PHONY: css watch deps run coffee mongoc clean

css:
	@scss --compass --update scss:static/styles

watch:
	@./bin/watch.bash

deps: css
	@npm install

run: deps
	${MAKE} coffee

coffee:
	@./node_modules/coffee-script/bin/coffee server.coffee

mongo:
	mongo frwrld

clean:
	@rm -rf node_modules
