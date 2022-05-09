# apcupsd-influxdb2x-exporter

Credit to [atribe](https://github.com/atribe/apcupsd-influxdb-exporter) from where this script was forked. This is a personal adaptation of the
script for influxdb 2.x APIs. tested on Unraid and debian machines.
Dockerized Python script that will send data from [apcupsd](http://www.apcupsd.org/) to [influxdb 2.x](https://hub.docker.com/_/influxdb).

## How to build
Building the image is straight forward:
* Git clone this repo
* `docker build -t apcupsd-influxdb2x-exporter  .`

## Environment Variables
These are all the available environment variables, along with some example values, and a description.

| Environment Varialbe | Example Value | Description |
| -------------------- | ------------- | ----------- |
| WATTS |  1000 | if your ups doesn't have NOMPOWER, set this to be the rated max power, if you do have NOMPOWER, don't set this variable |
| APCUPSD_HOST | 192.168.1.100 | host running apcupsd, defaults to the value of influxdb_host |
| INFLUXDB_HOST | 192.168.1.101 | host running influxdb |
| HOSTNAME | unraid | host you want to show up in influxdb. Optional, defaults to apcupsd hostname value|
| INFLUXDB_DATABASE | apcupsd | db name for influxdb. optional, defaults to apcupsd |
| INFLUXDB_V2_URL | http://192.168.1.101:8086 | influxDB url |
| INFLUXDB_V2_ORG | organisation | bucket organisation name  |
| INFLUXDB_V2_TOKEN | your_token | Your user API token |
| INTERVAL | 10 | optional, defaults to 10 seconds |
| VERBOSE | true | if anything but true docker logging will show no output |

## How to Use

### Run docker container directly
```bash
docker run --rm  -d --name="apcupsd-influxdb-exporter" \
    -e "WATTS=800" \<F2>
    -e "INFLUXDB_HOST=10.0.1.11" \
    -e "APCUPSD_HOST=10.0.1.11" \
	-e "INFLUXDB_V2_URL: http://192.168.95.200:8086
	-e "INFLUXDB_V2_ORG: my_org" \
	-e "INFLUXDB_V2_TOKEN: my_api_token_from_influxdb==
    -t kroumann/apcupsd-influxdb2x-exporter
```
Note: if your UPS does not include the NOMPOWER metric, you will need to include the WATTS environment variable in order to compute the live-power consumption
metric.

### Run from docker-compose
```bash

version: '3'
services:
  apcupsd-influxdb2x-exporter:
    image: kroumann/apcupsd-influxdb2x-exporter
    container_name: apcupsd-influxdb2x-exporter
    restart: always
    environment:
      WATTS: 800
      APCUPSD_HOST: 192.168.1.20
      INFLUXDB_HOST: 192.168.1.20
      HOSTNAME: homeserver 
      INFLUXDB_DATABASE: apcupsd
      INFLUXDB_PORT: 8086
      INFLUXDB_V2_URL: http://192.168.1.20:8086
      INFLUXDB_V2_ORG: my_org
      INFLUXDB_V2_TOKEN: my_token_from_influxdb==
      VERBOSE: true
```

If you want to debug the apcaccess output or the send to influxdb, set the environment variable "VERBOSE" to "true"

## Grafana integration

- [set up InfluxDB v2 data source as InfluxDB v1 data source and use InfluxQL](https://ivanahuckova.medium.com/setting-up-influxdb-v2-flux-with-influxql-in-grafana-926599a19eeb)
- [Map unmapped buckets](https://docs.influxdata.com/influxdb/v2.0/query-data/influxql/#map-unmapped-buckets)

