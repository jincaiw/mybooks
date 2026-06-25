.PHONY: validate pages clean tag

BOOK ?= 4.codex橙皮书

validate:
	python3 scripts/validate.py

pages:
	python3 scripts/prepare_pages.py

tag:
	VERSION=$$(cat VERSION | tr -d '[:space:]') && \
	git tag -a "$(BOOK)-v$$VERSION" -m "$(BOOK): Release v$$VERSION" && \
	echo "Created tag $(BOOK)-v$$VERSION. Push with: git push origin $(BOOK)-v$$VERSION"

clean:
	rm -rf docs/book.md docs/assets docs/downloads _site
