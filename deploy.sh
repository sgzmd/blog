#!/usr/bin/env bash

set -x

hugo
rsync -rzav -e "/usr/bin/ssh -i ~/.ssh/linode -p9821" ./public/ sgzmd@new.aaa-design.info:/var/www/blog