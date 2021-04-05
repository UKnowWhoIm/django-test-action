#!/bin/bash
PARALLEL=true
export SETTINGS_FILE="./testproject/settings.py"
export DB_HOST='127.0.0.1'
export DB_PORT='5432'

service postgresql start

# Setup database
python add_psql.py
echo "Added postgres config to your settings file"

echo "Migrating DB"
python manage.py migrate

echo "Running your tests"
if [ $PARALLEL ]; then
    python manage.py test --parallel
else 
    python manage.py test
fi