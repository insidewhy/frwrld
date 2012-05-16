.PHONY: css css-watch run clean

css:
	scss --compass --update scss:static/styles

css-watch:
	scss --compass --watch scss:static/styles

run: css
	node frwrld.js

clean:
	@rm -rf node_modules
