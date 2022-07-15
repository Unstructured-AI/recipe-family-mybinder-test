[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Unstructured-AI/recipe-family-mybinder-test/core-36/mybinder-test)

# Recipe Family - MyBinder Test

This is a test to see if we can spin up a MyBinder notebook from out recipe templates.

## Getting Started

To build the Docker container, run `make docker-build`. After that, you can run `make run-local`
to spin up a local `docker-compose` for the container. You'll be able to access `jupyter` at
`http://localhost:8888`. The `docker-compose` mounts the `recipe-notebooks` and
`exploration-notebooks` directories. Any changes you make while running the `docker-compose`
will get picked up locally.

To stop the local container, run `make stop-local`.

Note that since the `Dockerfile` installs `doc-prep` over SSH, you'll need access to the `doc-prep`
repo and your SSH keys store under `${HOME}/.ssh` for the Docker build to work.
