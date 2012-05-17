.PHONY: css css-watch deps run clean

css:
	scss --compass --update scss:static/styles

css-watch:
	scss --compass --watch scss:static/styles

deps:
	npm install

run: css deps
	./node_modules/coffee-script/bin/coffee server.coffee

clean:
	@rm -rf node_modules
