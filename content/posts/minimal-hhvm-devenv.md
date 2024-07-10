---
title: "Minimal HHVM Development Environment"
date: 2024-07-10T03:15:17+01:00
draft: false
---

Recently I've been playing a bit with Facebook's [Hack
language](https://docs.hhvm.com/hack/) and HHVM. To be perfectly honest, I did a
several attempts to get going with it - and it wasn't a particularly smooth
ride.

To get it out of the way - using Hack outside of Facebook is a bit of a pain
(then again, using `google3` outside of Google is not possible at all, so it's
all relative). The documentation is a bit all over the place, and half of the
repos are marked as archived / not updated anymore. As a cherry on top, they
dropped support for Mac / Homebrew, so using Hack on a Mac is really hard -
impossible for Apple Silicon Macs. 

So, you have to have a Linux machine, running on x86_64. And on top of that, you
_will_ have to use Docker, because getting exact configuration and set of
dependencies that makes HHVM happy is nearly impossible (at least I failed to).

**TL;DR** if you want to get _Hack_ing straight away, skip everything and go to
the last section, otherwise keep reading.

If you do use Docker though, and VS Code, and Hack's VS Code [extension](https://marketplace.visualstudio.com/items?itemName=pranayagarwal.vscode-hack) (which is
presumably the same one Meta is using internally - or very similar!) then it
becomes manageable. 

Broadly, there are 3 steps involved:

1. Set up a Docker container with HHVM and all the right dependencies
2. Starting the container and mounting your project directory to it
3. Configuring VS Code to use this container as your development environment
   using [Dev
   Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.

## Creating docker image

This step achieves two things: we have a container with HHVM, and we have PHP
composer pre-installed in it, which we'll need later.

```Dockerfile 
# Use a base image that supports HHVM
FROM hhvm/hhvm:latest

# Install Composer
RUN apt-get update && \
    apt-get install -y curl git unzip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Composer's global bin directory to the PATH
ENV PATH /root/.composer/vendor/bin:$PATH

# Set the working directory
WORKDIR /workspace
```

This is the part which really doesn't work well on anything that is not x86_64
Linux - the container only provides `linux/amd64` architecture (and is built on
Ubuntu 20.04 which is getting kinda dated). 

## Starting the container

Technically we can start the container from within dev container configuration,
but I found that it makes a lot more sense to externalise it. For that, we use
compose:

```yaml
version: '3.8'

services:
  minhack:
    build:
      context: .
      dockerfile: hhvm.dockerfile
    platform: linux/amd64
    volumes:
      - ./:/mnt/project
    tty: true
```

This is a very simple `docker-compose.yml` file. It builds the image from the
dockerfile provided above, mounts the current directory to `/mnt/project` in the
container and starts the service named `minhack` - which is the name we'll use
in dev container config.

## Dev Container

This is the part where we tell VS Code to use the container we just created as
the development environment. It goes to `.devcontainer/devcontainer.json` in
your project directory:

```json
{
    "name": "Minimal HHVM Development Container",
    "dockerComposeFile": [ "../docker-compose.yml" ],
    "service": "minhack",
    "workspaceFolder": "/workspace",
    "shutdownAction": "stopCompose",
    "mounts": [
      "source=${localWorkspaceFolder},target=/workspace,type=bind,consistency=cached"
    ],
    "customizations": {
      "vscode": {
        "extensions": [
          "pranayagarwal.vscode-hack",
          "ms-azuretools.vscode-docker"
        ]
      }
    },
    "remoteUser": "root",
    "postCreateCommand": "apt-get update && apt-get install -y git && composer install"
  }
```

Few things are heppning here. We tell VS Code to use the `docker-compose.yml` we
created earlier, and to use the service named `minhack`. We also mount the
project folder as `/workspace` and instruct VS Code to stop compose on shutdown.
We instruct VS Code to install two extensions - Hack and Docker. Finally, on the
post-install step we update the package list and install `git` and run `composer
install` which will install all the dependencies for your project (listed in
`composer.json` - see example in the repo linked below).

## Quick Start

While I do realise that usually this section _starts_ any instruction, not
finishes it, I stand corrected. If you just want to get _Hack_ing straight away,
do the following:

1. Download the zip file from
   [github.com/sgzmd/hack-minimal](https://github.com/sgzmd/hack-minimal)
2. Open this directory in VS Code
3. Install Dev Containers extension if not installed already
4. Ctrl/Command-Shift-P => "Rebuild and reopen in container".

From now on, you can edit `src/main.hack` and run it with `hhvm src/main.hack`.
Try running tests by `vendor/bin/hacktest tests/` - you should see tests
passing. At some point I will update that repo to include minimal web app setup
(technically this is exactly what Hack was created for), but for now this is it.