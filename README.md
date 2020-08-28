# docker-xaseco-v2

## Description
Dockerized version of Xymph's XAseco for Trackmania Nations/United Forever. 

The image can be started with default settings and a mandatory MySQL connection, but is extensible with custom config files and dynamic plugin loading.

## Installation
This image is available from Docker Hub [fanyx/docker-xaseco](https://hub.docker.com/r/fanyx/docker-xaseco "fanyx/docker-xaseco").

You can find my dockerized TMNF-Server at [fanyx/docker-tmserver](https://github.com/fanyx/docker-tmserver "fanyx/docker-tmserver"). This is the advised method but you should also be able to run on Docker host networking.

## Usage
`docker run -e {required environment variables} fanyx/docker-xaseco:[tag]`

### docker-compose
Sample file: `[docker-compose.yml](docker-compose.yml)`

Integrate this with the rest of your compose file if you're composing multiple services.

Read the rest of the documentation to see all configuration possibilities.

### Environment
#### Trackmania Server
```
Required:
- $SUPERADMIN_PASSWORD
Optional:
- $MASTERADMIN_LOGIN     | ingame MasterAdmin
- $TMSERVER_HOST         | Default: "trackmania"
- $TMSERVER_PORT         | Default: "5000"
```
#### MySQL
```
Required:
- $MYSQL_LOGIN
- $MYSQL_PASSWORD
- $MYSQL_DATABASE
Optional:
- $MYSQL_HOST            | Default: "db"
```

### Plugins
You can mount your custom plugin directory over the existing one. Clone the repository and copy the default direcotory from [xaseco/plugins](xaseco/plugins) to the desired location. Then add your custom plugins or disable them by moving them to the `disabled` subdirectory. Only plugins in the root plugins directory will be loaded.

**!! Warning !!**

Make sure you know which plugins are core to your functionality (like plugin.localdatabase.php) and keep those in your directory at all times.

Mount your plugins directory at `/app/plugins`. See the sample `docker-compose.yml` for an example.

### Custom config files
Using only the environment variables the core config files get loaded from [xaseco/\_config](xaseco/_config). You can only add or overwrite these with custom config files but are unable to remove them to ensure functionality.

**INFO**

You can even overwrite `config.xml` and `localdatabase.xml` this way.

To load custom plugins correctly you have to add the respective config files for the plugins. This is done with this directory.

Mount your config directory at `/app/config`. See the sample `docker-compose.yml` for an example.

## Contributing
If you have any recommendations or proposals for code changes, feel free to fork, edit and submit pull requests!

I don't write the most efficient bash code but it does what it should.
