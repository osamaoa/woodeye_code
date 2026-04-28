.PHONY: test lint typecheck format-check check

test:
	pytest

lint:
	ruff check .

format-check:
	ruff format --check .

typecheck:
	mypy src tests

check: lint format-check typecheck test
