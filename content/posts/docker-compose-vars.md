---
title: "Docker Compose Vars"
date: 2023-03-10T13:48:07Z
draft: false
---

Docker has a somewhat complex relationship with arguments. For starters, one has to distinguish between build-time variables (a.k.a. `$ARG` in `Dockerfile`) and runtime variables (a.k.a. `$ENV`). Then, there are environment variables that are set at runtime, and there are variables that are set in `docker-compose.yml` files. Finally, there are variables that are set in `.env` files.

For one of my services, through trial and error I found a horribly inefficient way of passing data, which involved combination of both `$ARG`s and `$ENV`s. It was a mess, and I was not happy with it. Worst of all (and I found it out only accidentally) that I was passing some tokens into the built image; that was the last straw.

This will serve more like a note to myself than anything else, but I hope it will be useful to someone else.

`Dockerfile`:

```
FROM alpine

CMD ["sh", "-c", "echo \"Hello world, $USERNAME\""]
```

`docker-compose.yml`:

```
version: '3.7'

services:
  my-service:
    build: .
    environment:
      - USERNAME=${USERNAME}
```

`basic.env`:
```
USERNAME=sgzmd
```

To run this abomination, one would have to do:

```
docker-compose --env-file basic.env up
```

It would print something like that:
    
```
[+] Running 1/0
⠿ Container dockertest-my-service-1  Recreated   0.0s
Attaching to dockertest-my-service-1
dockertest-my-service-1  | Hello world, sgzmd
dockertest-my-service-1 exited with code 0
```

This is a very basic example, but it shows how to pass a variable from the host environment into the container. Hope this helps someone (and I'll be definitely fixing my own service soon).