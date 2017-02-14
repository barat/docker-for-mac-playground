#!/bin/bash

# Tune fsync perf for docker mac per
# https://github.com/docker/for-mac/issues/668
# NB: You must be on Docker 1.12.2-rc1-beta27 or greater

cd ~/Library/Containers/com.docker.docker/Data/database/
f="com.docker.driver.amd64-linux/disk/full-sync-on-flush"
git reset --hard
cat $f
echo "false" > $f
git add $f && git commit -s -m "Disable flushing"
echo "You should now restart Docker for Mac."