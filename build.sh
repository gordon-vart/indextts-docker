#!/bin/bash
set -e

sudo docker build --no-cache  --progress=plain -t gordon-vart/indextts .
