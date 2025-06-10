# senzing-tutorial-in-python

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

# work in progress

# TL;DR

Interactively learn the Senzing API with Jupyter Labs.

- Run: `docker run -it -p 8888:8888 --rm --name jupyter senzing/senzing-tutorial-in-python`
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

- Tutorial 1 - The story thus far and add a record
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
Re-running the docker image will clear any work done and start from scratch. To
persist work locally, take a look at the [Run with local directory mounted](#run-with-local-directory-mounted) section.

```console
docker run \
    --interactive \
    --tty \
    --publish 8888:8888 \
    --rm \
    --name jupyter \
    senzing/senzing-tutorial-in-python
```

or a more concisely:

```console
docker run -it -p 8888:8888 --rm --name jupyter senzing/senzing-tutorial-in-python
```

## Run with local directory mounted

Any changes made in a container exists only as long as the container is running.
In order for changes to survive stopping and re-running the docker image, they
must be saved to the host. To do this mount a directory into the container when
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
    --volume $(pwd):/home/user/work \
    senzing/senzing-tutorial-in-python
```

or a more concisely:

```console
docker run -it -p 8888:8888 --rm --name jupyter -v $(pwd):/home/user/work senzing/senzing-tutorial-in-python
```

docker run -it -p 8888:8888 --rm --name jupyter -v ./senzing-examples:/home/user/work/senzing-examples -v ./senzing-tutorials:/home/user/work/senzing-tutorials senzing/senzing-tutorial-in-python

This mounts the current directory (`pwd`) as the `work` directory in the container. Any
files saved into that directory will be saved outside the container and therefore
not lost when the container is brought down. Any directory can be substituted for
the `$(pwd)` in the command. EG `...-v /home/user/my/stuff:/home/user/work`. Likewise,
the local directory can be mounted in any directory. EG `...-v /home/user/my/stuff:/home/user/stuff`.
Multiple volumes may also be defined with addition `-v` parameters. Note: you must
use an absolute path to your host(local) directory.

# Versioning

A small note about versioning. The releases of this repo are versioned following
[Semantic Versioning]. The caveat is that the release follow Senzing versioning for
major and minor with patch versions specific to this repo. The rationale being that
the tutorials and examples herein should work on any patch level of the major and
minor versions of Senzing.

# TODO:

- API reference into image
- update links to API reference
- Build switch for java and python?

[Semantic Versioning]: https://semver.org/spec/v2.0.0.html
[Senzing Garage]: https://github.com/senzing-garage
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[Senzing]: https://senzing.com/
