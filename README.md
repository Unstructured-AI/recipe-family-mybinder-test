# Recipe Family - <RECIPE FAMILY NAME>

<ADD DESCRIPTION OF RECIPE FAMILY>

### Updates TODO list

- [ ] Update the recipe family name and description in `README.md` (this file)
- [ ] Update the recipe family name in the `Makefile`
- [ ] Update the recipe family name in `recipe-family.yaml`
- [ ] If needed, install additional dependencies in the `Dockerfile`
- [ ] Update the recipe name in `docker-compose.yml`
- [ ] Add any additional requirements you need to `requirements/base.in` and run `make pip-compile`

## Getting Started

To build the Docker container, run `make docker-build`. After that, you can run `make run-local`
to spin up a local `docker-compose` for the container. You'll be able to access `jupyter` at
`http://localhost:8888`. The `docker-compose` mounts the `recipe-notebooks` and
`exploration-notebooks` directories. Any changes you make while running the `docker-compose`
will get picked up locally.

To stop the local container, run `make stop-local`.

Note that since the `Dockerfile` installs `doc-prep` over SSH, you'll need access to the `doc-prep`
repo and your SSH keys store under `${HOME}/.ssh` for the Docker build to work.
