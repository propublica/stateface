state-plane albers:
	cd tools && $(MAKE) $@

publish:
	git checkout gh-pages
	git merge master
	git push
	git checkout master

.PHONY: publish state-plan albers
