<a href="https://elest.io">
  <img src="https://upload.wikimedia.org/wikipedia/commons/5/52/Lemmy_logo.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Lemmy, verified and packaged by Elestio

[Lemmy](https://github.com/LemmyNet/lemmy.git) is a selfhosted social link aggregation and discussion platform.

<img src="https://github.com/elestio-examples/lemmy/raw/main/lemmy.png" alt="lemmy" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/lemmy">fully managed Lemmy</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you are interested in exploring a decentralized and community-oriented approach to online content.

[![deploy](https://github.com/elestio-examples/lemmy/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?soft=lemmy)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/lemmy.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./pictrs
    chown -R 991:991 ./pictrs
    mkdir -p ./nginx.conf
    chown 700 ./nginx.conf
    mkdir -p ./lemmy.hjson
    chown 700 ./lemmy.hjson
    mkdir -p ./pgdata
    chown 700 ./pgdata

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:6580`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"

    services:
      proxy:
        image: nginx:1-alpine
        ports:
          - "172.17.0.1:6580:8536"
        volumes:
          - ${folderName}/nginx.conf:/etc/nginx/nginx.conf:ro,Z
        restart: always
        depends_on:
          - pictrs
          - lemmy-ui

      lemmy:
        image: elestio4test/lemmy:${SOFTWARE_VERSION_TAG}
        restart: always
        environment:
          - RUST_LOG="warn"
          - LEMMY_DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}
        volumes:
          - ${folderName}/lemmy.hjson:/config/config.hjson:Z
        depends_on:
          - postgres
          - pictrs

      lemmy-ui:
        image: dessalines/lemmy-ui:${SOFTWARE_VERSION_TAG}
        environment:
          - LEMMY_UI_LEMMY_INTERNAL_HOST=lemmy:8536
          - LEMMY_UI_LEMMY_EXTERNAL_HOST=localhost:1236
          - LEMMY_UI_HTTPS=true
        depends_on:
          - lemmy
        restart: always

      pictrs:
        image: asonix/pictrs:0.3.1
        hostname: pictrs
        environment:
          - PICTRS__API_KEY=${API_KEY}
        depends_on: 
          - postgres
        volumes:
          - ./volumes/pictrs:/mnt
        restart: always

      postgres:
        image: elestio/postgres:15
        hostname: postgres
        environment:
          - POSTGRES_USER=${POSTGRES_USER}
          - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
          - POSTGRES_DB=${POSTGRES_DB}
        volumes:
          - ${folderName}/pgdata:/var/lib/postgresql/data:Z
        restart: always

### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
|       API_KEY        |     api-key     |
|  POSTGRES_PASSWORD   |    password     |
|    POSTGRES_USER     |    user-name    |
|     POSTGRES_DB      |     db-name     |

# Maintenance

## Logging

The Elestio Lemmy Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/LemmyNet/lemmy">Lemmy Github repository</a>

- <a target="_blank" href="https://join-lemmy.org/docs/">Lemmy documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/lemmy">Elestio/Lemmy Github repository</a>
