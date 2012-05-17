.PHONY: css css-watch coffee-watch deps run clean

css:
	@scss --compass --update scss:static/styles

css-watch:
	@scss --compass --watch scss:static/styles

coffee-watch:
	@./node_modules/coffee-script/bin/coffee  -o static/js -w web/*.coffee

deps: css
	@npm install

run: css deps
	@./node_modules/coffee-script/bin/coffee server.coffee

clean:
	@rm -rf node_modules
