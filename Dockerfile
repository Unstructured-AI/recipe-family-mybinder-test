from python:3.8-slim-buster

RUN python -m pip install pip==22.1.2

RUN apt-get update \
&& apt-get install -y git

# create user with a home directory
ARG NB_USER
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
     ${NB_USER}

WORKDIR ${HOME}

ENV PYTHONPATH="${PYTHONPATH}:${HOME}"

COPY requirements/dev.txt requirements-dev.txt
COPY requirements/base.txt requirements-base.txt
COPY doc_recipe doc_recipe

RUN apt-get update; apt-get install -y gcc
# NOTE(robinson) - Can remove the secret mount once the repo is public
RUN --mount=type=secret,id=known_hosts,dst=/root/.ssh/known_hosts \
    --mount=type=secret,id=ssh_key,dst=/root/.ssh/id_rsa \
    ssh-keyscan -H -t rsa github.com \
    && pip install --no-cache -r requirements-base.txt \
    && pip install --no-cache -r requirements-dev.txt
