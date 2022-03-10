FROM debian:latest
# use debian base image since python images are 
# incompatible with python packages installed via apt (required for olm)
# https://github.com/docker-library/python/issues/43#issuecomment-94095495
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        python3 \
        python3-pip \
        python-is-python3 \
        python3-olm \
        git
RUN pip install --upgrade pip