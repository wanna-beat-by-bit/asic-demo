.PHONY: dev-build dev subdir_src test_all context

dev-build:
	docker compose build veridev

dev:
	docker compose up veridev

test_all:
	$(MAKE) -C src test_all

context:
	$(MAKE) -C src context