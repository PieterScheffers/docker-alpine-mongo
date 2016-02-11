# docker-alpine-mongo

This repository contains Dockerfile for [MongoDB 3.2](https://www.mongodb.org)
container, based on the [Alpine 3.3](https://hub.docker.com/_/alpine/) image.

Why ? the official mongo image size: 317 MB, alpine-mongo: 133 MB

## Install

As a prerequisite, you need [Docker](https://docker.com) to be installed.

To download this image from the public docker hub:

	$ docker pull mvertes/alpine-mongo

To re-build this image from the dockerfile:

	$ docker build -t mvertes/alpine-mongo .

## Usage

To run `mongod`:

	$ docker run -d --name mongo -p 27017:27017 mvertes/alpine-mongo

Now, on the same host where the mongodb container is running, to trace
database activity in real-time:

	$ docker exec -ti mongo mongosniff

Or to connect a local mongo client:

	$ docker exec -ti mongo mongo

## Limitations

- On MacOSX, volumes located in a shared folder are not supported,
  due to a limitation of virtualbox (default docker-machine driver)
  not supporting fsync().