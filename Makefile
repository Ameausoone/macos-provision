

.PHONY: super-linter
super-linter:
	docker run -e RUN_LOCAL=true -v $$(pwd):/tmp/lint github/super-linter
