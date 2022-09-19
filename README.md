# sz-jupyter is a work in progress

# TL;DR

Interactively learn the Senzing API with Jupyter.
- Run: `docker run -it -p 8888:8888 --rm --name jupyter roncewind/sz-jupyter`
- Open link (cmd-click on mac)

# Intro (TODO)

- Senzing library
- Purpose
- Examples vs tutorials?
    - Examples show how to do one thing
    - Tutorials form a story that weave examples together
    - Tutorial should have a final "product"

## Tutorial list (TODO)

should probably put in the tutorial sub-dir

What story am I telling?

- Fraud detection?
- bad guy hunting?
- ???

- Tutorial 1 - add a record
- Tutorial 2 - add a datasource
- Tutorial 3 - add truthset
- Tutorial 4 - search
- Tutorial 5 - get record, get entity, what is an entity?
- Tutorial 6 - why... what is why?
- Tutorial 7 -
- Tutorial ...
- Tutorial M - senzing config topics?
- Tutorial N - beyond Jupyter?
- Tutorial N+1 - build non-jupyter image and run
- Tutorial N+2 - connect to non-SQLite database
- Tutorial N+3 - deploy tutorial image with docker compose stack
- Tutorial N+4 - deploy tutorial image with cloudformation
- Tutorial N+5 - other deployment topics?

## Run Jupyter

Any changes made in a container exists only as long as the container is running.
Re-running the docker image will clear any work done and start from scratch.  To
persist work locally, take a look at the [Run with local directory mounted](#run-with-local-directory-mounted) section.

```console
docker run \
    --interactive \
    --tty \
    --publish 8888:8888 \
    --rm \
    --name jupyter \
    roncewind/sz-jupyter
```

or a more concisely:

```console
docker run -it -p 8888:8888 --rm --name jupyter roncewind/sz-jupyter
```

## Run with local directory mounted

Any changes made in a container exists only as long as the container is running.
In order for changes to survive stopping and re-running the docker image, they
must be saved to the host.  To do this mount a directory into the container when
it is run.

Map the current directory into the Docker container so that changes to notebooks are
saved locally.

```console
docker run \
    --interactive \
    --tty \
    --publish 8888:8888 \
    --rm \
    --name jupyter \
    --volume $(pwd):/home/jovyan/work \
    roncewind/sz-jupyter
```

or a more concisely:

```console
docker run -it -p 8888:8888 --rm --name jupyter -v $(pwd):/home/jovyan/work roncewind/sz-jupyter
```

docker run -it -p 8888:8888 --rm --name jupyter -v ./senzing-examples:/home/jovyan/work/senzing-examples -v ./senzing-tutorials:/home/jovyan/work/senzing-tutorials roncewind/sz-jupyter

This mounts the current directory (`pwd`) as the `work` directory in the container.  Any
files saved into that directory will be saved outside the container and therefore
not lost when the container is brought down.  Any directory can be substituted for
the `$(pwd)` in the command.  EG `...-v /home/user/my/stuff:/home/jovyan/work`.  Likewise,
the local directory can be mounted in any directory.  EG `...-v /home/user/my/stuff:/home/jovyan/stuff`.
Multiple volumes may also be defined with addition `-v` parameters.  Note:  you must
use an absolute path to your host(local) directory.

# Versioning

A small note about versioning.  The releases of this repo are versioned following
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).  The caveat is that
the release follow Senzing versioning for major and minor with patch versions
specific to this repo.  The rationale being that the tutorials and examples herein
should work on any patch level of the major and minor versions of Senzing.

# TODO:

- API reference into image
- update links to API reference
- Build switch for java and python?
