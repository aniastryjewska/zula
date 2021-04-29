FROM flyway/flyway

USER root

COPY docker/script.sh /var/run/entrypoint.sh
RUN chmod +x /var/run/entrypoint.sh
COPY scripts /flyway/sql

ENTRYPOINT /var/run/entrypoint.sh
