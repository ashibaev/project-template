.PHONY : init black-lint flake8 mypy lint pretty lock

SHELL := /bin/bash
CODE = hooks
ALL = $(CODE)
PYTHON := python3.9

VENV ?= .venv
JOBS ?= 4

init:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/python -m pip install --upgrade pip
	$(VENV)/bin/python -m pip install poetry

install:
	$(VENV)/bin/poetry install

lock:
	$(VENV)/bin/poetry lock

black-lint:
	$(VENV)/bin/black --skip-string-normalization --check $(ALL)

flake8:
	$(VENV)/bin/flake8 --jobs $(JOBS) --statistics --show-source $(ALL)

mypy:
	$(VENV)/bin/mypy $(CODE)

lint: black-lint flake8 mypy

pretty:
	$(VENV)/bin/isort $(ALL)
	$(VENV)/bin/black --skip-string-normalization $(ALL)
