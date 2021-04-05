FROM python:3.8.1-slim

RUN set -eux; \
	groupadd -r postgres --gid=999; \
	useradd -r -g postgres --uid=999 --home-dir=/var/lib/postgresql --shell=/bin/bash postgres; \
	mkdir -p /var/lib/postgresql; \
	chown -R postgres:postgres /var/lib/postgresql
RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql && chmod 2777 /var/run/postgresql


RUN apt-get update \
&& apt-get install -y --no-install-recommends postgresql libpq-dev python-psycopg2 \
&& apt-get purge -y --auto-remove \
&& rm -rf /var/lib/apt/lists/*

USER postgres
ENV DB_USER='test'
ENV DB_PASSWORD='test123'
ENV DB_NAME='testdb'

RUN  service postgresql start \
&& psql -c "CREATE USER ${DB_USER} WITH SUPERUSER PASSWORD '${DB_PASSWORD}';ALTER USER ${DB_USER} CREATEDB;" \
&& psql -c "CREATE DATABASE ${DB_NAME} WITH owner ${DB_USER} encoding 'utf-8'" \
&& psql -c "\l"
USER root


COPY ./django-project /django-project
COPY ./scripts /django-project
WORKDIR /django-project
RUN ls
# Install dependancies
RUN python -m pip install -r requirements.txt
RUN pip install psycopg2-binary
CMD ["./entrypoint.sh"]