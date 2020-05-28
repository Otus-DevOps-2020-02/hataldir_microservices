FROM grafana/grafana:5.1.0

COPY prometheus.yml /etc/grafana/provisioning/datasources/
COPY trickster.yml /etc/grafana/provisioning/datasources/
COPY dashboards.yml /etc/grafana/provisioning/dashboards/
COPY dashboards/* /etc/grafana/provisioning/dashboards/
