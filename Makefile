state-plane albers:
	cd tools && $(MAKE) $@

publish:
	git checkout gh-pages
	git merge master
	git push origin gh-pages
	git checkout master

css:
	python reference/cssclass.py < reference/stateface.json > reference/stateface.css

docs: css
	cd reference && ruby stateface.rb

pkg:
	rm pkg/*
	zip -r pkg/stateface.zip font
	tar -cvzf pkg/stateface.tar.gz font

.PHONY: publish state-plan albers docs pkg
