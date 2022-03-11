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
        imagemagick \
        git

RUN pip install --upgrade pip \
    && pip install --no-cache git+https://github.com/moritzj29/matrix-photos

# initialize folder structure
RUN mkdir /data \
    && mkdir /data/photoframe \
    && mkdir /data/photoframe/image_local \
    && mkdir /data/photoframe/log \
    && mkdir /data/photoframe/conf

VOLUME [ "/data/photoframe" ]

CMD [ "python", "-m", "matrix_photos", "-c", "/data/photoframe/conf/config.yml" ]