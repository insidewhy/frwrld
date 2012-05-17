.PHONY: css css-watch run clean

css:
	scss --compass --update scss:static/styles

css-watch:
	scss --compass --watch scss:static/styles

run: css
	./node_modules/coffee-script/bin/coffee server.coffee

clean:
	@rm -rf node_modules
