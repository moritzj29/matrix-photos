# matrix-photos


[![Latest PyPI version](https://img.shields.io/pypi/v/matrix-photos)](https://pypi.org/project/matrix-photos/)
[![CI build status](https://img.shields.io/github/workflow/status/universalappfactory/matrix-photos/Deploy%20to%20PyPI/main)](https://github.com/universalappfactory/matrix-photos/actions/workflows/pypi-deploy.yml)

This aims to be a simple [matrix](https://matrix.org/) client for the photOS DIY photoframe.

Matrix is an open standard for secure, decentralised, real-time communication.

For photOS please checkout https://github.com/avanc/photOS for more information.

This client can be used to transfer files (pictures/photos) to the photoframe with end to end encryption support.
The idea is, that trusted users just can create a matrix room and invite the photoframe matrix user.
The photoframe user will automatically join this room and download all media sent to this room (You can specify which mimetypes are allowed).

## Configuration

There is a config-example.yml in this project which should be mostly self-explaining.

It is possible to add textmessages to the images. This is done with the tool 'convert'.
The client automatically adds the first message after you post media content to the latest image when write_text_messages is set to true.

You can also optionally define an admin_user which can run some administration commands on the photoframe.
If you define an admin user then just send !help from the specified user to the chatroom and the client sends you a list of available commands.

## Running

Just create a virtual environement install the requirements and you can run the client.

```
    python -m matrix_photos -c /path/to/config.yml
```

## Run in Docker

Set up a `docker-compose` file similar to:
```yml
version: '3'

services:
  matrix_photos:
    image: ghcr.io/moritzj29/matrix_photos:latest
    volumes:
      - ./data:/data/photoframe
      # - ./images:/data/photoframe/images_local
    environment:
      - TZ=Europe/Berlin

  matrix_photos_db:
    image: postgres:latest
    environment:
      POSTGRES_PASSWORD: postgres
    volumes:
      - ./db:/var/lib/postgresql/data
```
Provide a valid config file at `/data/photoframe/conf/config.yml`
within the container. Make sure to adjust the URL of the postgres
database to match the container service name.

Since the config file contains sensitive information like passwords
for the matrix and database accounts, make sure to limit the access
permissions of `conf.yml`.

## Development

If you want to develop or test the client, there is a docker-compose file in the docker directory which starts a matrix synapse homeserver,
a postgres database, an element matrix client and pgadmin if you want to check the database.

### devcontainer
It is possible to use the VS code `.devcontainer` for development. It spins up a debian based container for the `matrix_photos` library and a postgres database container. Be sure to use an appropriate `config.yml` file, especially changing the postgres database URL to match the `docker-compose.yml`:
```yaml
# postgres://user:password@database_service_name
database_url: postgres://postgres:postgres@matrix_photos_db
```
The structure of the mounted `data` folder resembles the file structure present on installs of `photOS`. The `matrix_photos` source code is installed in editable mode by the devcontainer extension.
