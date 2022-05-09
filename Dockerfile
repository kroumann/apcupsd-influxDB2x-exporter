FROM python:alpine
RUN apk add tzdata
MAINTAINER kroumann <kroumann@gmail.com>

WORKDIR /src
COPY requirements.txt apcupsd-influxdb2x-exporter.py /src/
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "-u", "/src/apcupsd-influxdb2x-exporter.py"]
