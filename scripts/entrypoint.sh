#!/bin/bash
export SETTINGS_FILE="./$1/settings.py"
PARALLEL=$2
#export SETTINGS_FILE="./testproject/settings.py"
#PARALLEL=true

service postgresql start

# Setup database
python add_psql.py
echo "Added postgres config to your settings file"

echo "Migrating DB"
python manage.py migrate

echo "Running your tests"
if [ $PARALLEL ]; then
    echo "Enabled Parallel Testing"
    python manage.py test --parallel
else 
    python manage.py test
fi