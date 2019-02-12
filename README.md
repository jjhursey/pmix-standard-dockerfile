Dockerfile for [pmix-standard](https://github.com/pmix/pmix-standard) [Travis CI](https://travis-ci.org/pmix/pmix-standard)

### Building the container

```
docker build -t pmix-standard .
```

### Running the container

```
docker run --rm -it pmix-standard bash
```

### Publishing the container image

```
docker login
docker tag pmix-standard ${USER}/pmix-standard:latest
docker push ${USER}/pmix-standard:latest
```
