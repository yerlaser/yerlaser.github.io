# OpenSearch / ElasticSearch
Vector, Syslog (Syslog-ng or RSyslog) or even better let FileBeat send the data to LogStash
Fluentd (old) or FluentBit or LogStash or Vector process and enrich logs
OpenSearch or ElasticSearch to store, index and search using Query DSL or PPL (ES/QL).
For Dashboads it uses DQL

## Elasticsearch Basics
- Document: basically a record, but it doesn’t have to be structured. a log line is a document (structured record)

- Index: A collection of documents. An index is identified by a name (that must be all lowercase) and this name is used to refer to the index when performing indexing, search, update, and delete operations against the documents in it.

## Sending data to Elasticsearch
- Direct API call - POST to Elasticsearch directly (usually not what you want)

- Logstash - separate component that sits in front of Elasticsearch. Sort of like a reverse proxy. Documents (log records) are being sent to Logstash where they can be transformed, enriched, sent to other loggers, etc. Logstash can execute plugins which give it a lot of power. But that also makes it costly in terms of resources. Amazon Elasticsearch service does NOT include Logstash, which means that it’s another thing to setup, pay for and worry about.

- Ingest node pipelines - introduced with Elasticsearch 5, can do some light ETL, enough for many use cases. Ingest nodes are part of Elasticsearch, no need to set up anything extra.

- Beats (Filebeat) - Filebeat reads (log) files line by line as they are written and sends data to Elasticsearch using one of the methods above. Part of the Beats family of data shippers.

- In AWS there are more options. Like, a Lambda function that gets triggered when a log is uploaded to S3 or CloudWatch. Or using Firehose to load logs into Elasticsearch. Won’t talk about these.

# VictoriaMetrics / Prometheus
NodeExporter or libraries for custom apps export over plain HTTP (port 9200)
VM has vmagent which can collect and possibly transform data and push
FluentBit can do same
Vector can do same

## Elastic Search includes TSDS (time series data streams) to collect time series

Grafana for Prometheus

# Grafana/Loki
Uses PromTail to ship logs (equivalent of FileBeat or FluentBit)
