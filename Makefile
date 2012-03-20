state-plane albers:
	cd tools && $(MAKE) $@

publish:
	git checkout gh-pages
	git merge master
	git push
	git checkout master

docs:
	cd reference && ruby stateface.rb

.PHONY: publish state-plan albers docs
