.PHONY: clean run css css-watch

clean:
	@rm -rf node_modules

css:
	scss --compass --update scss:static/styles

css-watch:
	scss --compass --watch scss:static/styles

run: css
	node frwrld.js
