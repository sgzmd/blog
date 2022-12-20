#!/usr/bin/env bash

set -x

hugo
scp -P9821 -i ~/.ssh/linode -rv ./public/* sgzmd@new.aaa-design.info:/var/www/blog/
