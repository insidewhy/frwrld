.PHONY: watch deps run coffee mongoc clean wc

watch:
	@./bin/watch.bash

deps:
	@npm install # also generates css from scss and web js from coffee

run: deps
	${MAKE} coffee

coffee:
	@./node_modules/coffee-script/bin/coffee server.coffee

mongo:
	mongo frwrld

clean:
	@rm -rf node_modules

wc:
	wc -l scss/*.scss {,web/,schema/}*.coffee
