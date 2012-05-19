.PHONY: css watch deps run coffee clean

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

clean:
	@rm -rf node_modules
