A simple Dockerfile that uses the official Linux install procedure at https://docs.mattermost.com/install/install-ubuntu-2004.html

It exposes a non-HTTPS port at port 80. You can use caddy/nginx/etc to provide SSL termination if needed.

# Usage

1. Copy `config.json.ref` to `config.json` and edit appropriately.
2. Build the Dockerfile: `docker build -t simple-mattermost-docker .`
3. Launch the container with the following variables.

* `MM_SERVICESETTINGS_SITEURL` - SiteURL e.g. `http://mattermost.example/`
* `MATTERMOST_DB_TYPE` - `postgres` or `mysql`
* `MATTERMOST_DB_DATASOURCE` - depending on the database type, a string of either the form `postgres://mmuser:<mmuser-password>@<host-name-or-IP>:5432/mattermost?sslmode=disable&connect_timeout=10` or `mmuser:<mmuser-password>@tcp(<host-name-or-IP>:3306)/mattermost?charset=utf8mb4,utf8&writeTimeout=30s`

e.g.

```shell
# postgres
docker run --name my_postgres \
  -e POSTGRES_USER=mmuser \
  -e POSTGRES_DB=mattermost \
  -e POSTGRES_PASSWORD=mysecretpassword -d postgres

docker run --name my_mm -it \
  -e "MM_SERVICESETTINGS_SITEURL=http://mattermost.example" \
  -e "MATTERMOST_DB_TYPE=postgres" \
  -e "MATTERMOST_DB_DATASOURCE=postgres://mmuser:mysecretpassword@172.17.0.2:5432/mattermost?sslmode=disable&connect_timeout=10" \
  -d simple-mattermost-docker
# optional: -p 80:80
```

# Volumes to save

* `/opt/mattermost/data` - save this for all user-uploaded data
* `/opt/mattermost/plugins` and `/opt/mattermost/client/plugins` - Mattermost plugins
* `/opt/mattermost/logs` - logs (optional)
