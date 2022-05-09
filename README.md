# apcupsd-influxdb2x-exporter

Dockerized Python script that will send data from [apcupsd](http://www.apcupsd.org/) to [influxdb 2.x](https://hub.docker.com/_/influxdb).

## How to build
Building the image is straight forward:
* Git clone this repo
* `docker build -t apcupsd-influxdb-exporter  .`

## Environment Variables
These are all the available environment variables, along with some example values, and a description.

| Environment Varialbe | Example Value | Description |
| -------------------- | ------------- | ----------- |
| WATTS |  1000 | if your ups doesn't have NOMPOWER, set this to be the rated max power, if you do have NOMPOWER, don't set this variable |
| APCUPSD_HOST | 192.168.1.100 | host running apcupsd, defaults to the value of influxdb_host |
| INFLUXDB_HOST | 192.168.1.101 | host running influxdb |
| HOSTNAME | unraid | host you want to show up in influxdb. Optional, defaults to apcupsd hostname value|
| INFLUXDB_DATABASE | apcupsd | db name for influxdb. optional, defaults to apcupsd |
| INFLUXDB_USER | myuser | optional, defaults to empty |
| INFLUXDB_PASSWORD | pass | optional, defaults to empty |
| INFLUXDB_PORT |  8086 | optional, defaults to 8086 |
| INTERVAL | 10 | optional, defaults to 10 seconds |
| VERBOSE | true | if anything but true docker logging will show no output |

## How to Use

### Run docker container directly
```bash
docker run --rm  -d --name="apcupsd-influxdb-exporter" \
    -e "WATTS=600" \
    -e "INFLUXDB_HOST=10.0.1.11" \
    -e "APCUPSD_HOST=10.0.1.11" \
    -t atribe/apcupsd-influxdb-exporter
```
Note: if your UPS does not include the NOMPOWER metric, you will need to include the WATTS environment variable in order to compute the live-power consumption 
metric.

### Run from docker-compose
```bash
version: '3'
services:
  apcupsd-influxdb-exporter:
    image: atribe/apcupsd-influxdb-exporter
    container_name: apcupsd-influxdb-exporter
    restart: always
    environment:
      WATTS: 1000
      APCUPSD_HOST: 10.0.1.11
      INFLUXDB_HOST: 10.0.1.11
      INTERVAL: 5
```

If you want to debug the apcaccess output or the send to influxdb, set the environment variable "VERBOSE" to "true"
