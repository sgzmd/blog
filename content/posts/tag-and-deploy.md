---
title: "Tag and Deploy to Docker"
date: 2023-02-26T12:53:55Z
draft: false
---

I have a bunch of personal services which I deploy using Docker. One issue I was
constantly struggling with is how to know from which Git revision Docker
container was built - and how can I go to that revision easily. 

While in "serious" development you'd use a CI server and some form of release process, for my
toy service I ended up hacking together a very simple script that gives me just
enough to get the job done:

```
#!/usr/bin/env sh
set -x

# This creates a git tag name with the current date and time
tag=`date --iso-8601`T`date +%H-%M`

echo "Creating git tag $tag"

# Create and push the tag
git tag $tag
git push --tags

# Store the tag name to a file which will be eventually picked up in Docker build
echo $tag > version.txt

echo "Starting docker compose"

# Building and deploying the service using Docker Compose
docker compose up --build -d
```

While this is rudimentary, at the very least, at any moment in time, I can
figure which codebase container was built from.