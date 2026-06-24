.PHONY: validate pages clean tag

BOOK ?= 1.GitHub版本发布与云原生GitOps实战教程

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
