.PHONY: validate tag release help
.DEFAULT_GOAL := help

BOOK ?= 3.高考志愿填报红宝书
VERSION ?= $(shell cat books/$(BOOK)/VERSION 2>/dev/null | tr -d '[:space:]')

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

validate: ## Validate all books
	@for b in books/*/; do echo "=== Validating $$(basename $$b) ==="; $(MAKE) -C "$$b" validate 2>/dev/null || true; echo; done

validate-one: ## Validate a single book: make validate-one BOOK=3.高考志愿填报红宝书
	$(MAKE) -C books/$(BOOK) validate

tag: ## Create a release tag: make tag BOOK=3.高考志愿填报红宝书
	$(MAKE) -C books/$(BOOK) tag

release: validate-one tag ## Validate + create tag in one step: make release BOOK=3.高考志愿填报红宝书
	@echo "---"
	@echo "✅ Tag created. Push with:"
	@echo "   git push origin main"
	@echo "   git push origin $(BOOK)-v$(VERSION)"
