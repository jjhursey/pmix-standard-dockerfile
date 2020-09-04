Dockerfile for [pmix-standard](https://github.com/pmix/pmix-standard) [Travis CI](https://travis-ci.org/pmix/pmix-standard)

The image is hosted on DockerHub as [jjhursey/pmix-standard](https://hub.docker.com/r/jjhursey/pmix-standard). In the "running" examples below we will use that as our reference image.


### Running the container

This command will start the container running. Then you can checkout your repo and build.

```
docker run --rm -it jjhursey/pmix-standard bash
```

### Generating a PDF using the container

Variables (e.g, `CONTAINER`) are used for convenience and clarity in the examples. They are not required by the Docker image.

The `~/work/pmix-standard-docs/` is the path on the host machine where you want the PDF document to be copied to.

#### Primary PMIx Standard repo and custom branch

If `BRANCH` is omited then it will build `master` by default.

```
CONTAINER=jjhursey/pmix-standard
BRANCH="v3"

docker run --rm -v ~/work/pmix-standard-docs/:/home/pmixer/doc $CONTAINER ./bin/build-std.sh /home/pmixer/doc $BRANCH
```

#### Your fork and custom branch

```
CONTAINER=jjhursey/pmix-standard
BRANCH="issue_175_pr_123"
REPO="https://github.com/myuser/pmix-standard.git"

docker run --rm -v ~/pmix-standard-docs/:/home/pmixer/doc $CONTAINER ./bin/build-std.sh /home/pmixer/doc $BRANCH $REPO
```

### Your local directory

```
CONTAINER=jjhursey/pmix-standard
docker run --rm -v $PWD:/home/pmixer/doc $CONTAINER ./bin/build-std.sh /home/pmixer/doc inplace
```

### Building the container

```
docker build -t ${USER}/pmix-standard .
```

### Publishing the container image

```
docker login
docker push ${USER}/pmix-standard:latest
```
