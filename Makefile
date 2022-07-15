PACKAGE_NAME := doc_recipe
# ADD IN THE NAME OF YOUR RECIPE FAMILY HERE!
# RECIPE_FAMILY :=
PIP_VERSION := 22.1.2

###########
# Install #
###########

.PHONY: install
install: install-base install-nltk

## install-local:           installs all test and dev requirements
.PHONY: install-local
install-local: install-base install-dev install-nltk install-test

.PHONY: install-base
install-base:
	python3 -m pip install pip==${PIP_VERSION}
	pip install -r requirements/base.txt

.PHONE: install-nltk
install-nltk:
	python -c "import nltk; nltk.download('punkt')"
	python -c "import nltk; nltk.download('averaged_perceptron_tagger')"

.PHONY: install-test
install-test:
	pip install -r requirements/test.txt

.PHONY: install-dev
install-dev:
	pip install -r requirements/dev.txt

## pip-compile:             compiles all base/dev/test requirements
.PHONY: pip-compile
pip-compile:
	pip-compile requirements/base.in
	pip-compile requirements/dev.in
	pip-compile requirements/test.in


#########
# Build #
#########

## docker-build:						builds the docker container for the recipe
.PHONY: docker-build
docker-build:
	# NOTE(robinson) - Can remote the secret mount part when the repo is public
	DOCKER_BUILDKIT=1 docker build -f Dockerfile \
		--build-arg NB_USER=notebook-user \
		--secret id=known_hosts,src=${HOME}/.ssh/known_hosts \
		--secret id=ssh_key,src=${HOME}/.ssh/id_rsa \
		-t recipe-family-${RECIPE_FAMILY}:latest .

#########
# Local #
########

# run-local:								runs the container locally as a docker compose file
.PHONY: run-local
run-local:
	docker-compose -p ${RECIPE_FAMILY} up

# stop-local:								stops the container locally
.PHONY: stop-local
stop-local:
	docker-compose -p ${RECIPE_FAMILY} stop

#################
# Test and Lint #
#################

## test:                    runs all unittests
.PHONY: test
test:
	PYTHONPATH=. pytest test_${PACKAGE_NAME} --cov=${PACKAGE_NAME} --cov-report term-missing

## check:                   runs linters (includes tests)
.PHONY: check
check: check-src check-tests

## check-src:               runs linters (source only, no tests)
.PHONY: check-src
check-src:
	black ${PACKAGE_NAME} --check
	flake8 ${PACKAGE_NAME}
	mypy ${PACKAGE_NAME} --ignore-missing-imports

.PHONY: check-tests
check-tests:
	black test_${PACKAGE_NAME} --check
	flake8 test_${PACKAGE_NAME}

## tidy:                    run black
.PHONY: tidy
tidy:
	black ${PACKAGE_NAME}
	black test_${PACKAGE_NAME}
