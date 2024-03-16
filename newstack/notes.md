# OpenSearch / ElasticSearch
Syslog (Syslog-ng or RSyslog) or even better let FileBeat send the data to LogStash
Fluetd (old) or FluentBit or LogStash or Vector process and enrich logs
OpenSearch or ElasticSearch to store, index and search using Query DSL or PPL (ES/QL).
For Dashboads it uses DQL

# VictoriaMetrics / Prometheus
NodeExporter or libraries for custom apps export over plain HTTP (port 9200)
VM has vmagent which can collect and possibly transform data and push
FluentBit can do same
Vector can do same

## Elastic Search includes TSDS (time series data streams) to collect time series

Grafana for Prometheus

# Grafana/Loki
Uses PromTail to ship logs (equivalent of FileBeat or FluentBit)
