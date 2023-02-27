#!/bin/bash
# to generate Dockerfile
# pip install neurodocker # only the first time, then:
# neurodocker generate docker --base-image debian:buster \
# --pkg-manager apt \
# --ants version=2.4.1 \ > Dockerfile
# after that lines were commented out and ants version was replaced by 2.4.3 throughout the resulting Dockerfile

# This line will delete your image cache to get fresh logs (be careful):
# docker system prune -a -f
docker build -t ANTsRCore-arm64-debug . &> $(date +"%Y-%m-%d_%T")_build.log

       