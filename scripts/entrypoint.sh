#!/bin/bash
set -e

export SETTINGS_FILE="${GITHUB_WORKSPACE}/$1/settings.py"

service postgresql start

# Setup database
python /add_psql.py
echo "Added postgres config to your settings file"

pip install -r $3
echo "Migrating DB"
python manage.py migrate

echo "Running your tests"

# TODO: Find a better alternative
if [ "${2,,}" == "true" ]; then
    echo "Enabled Parallel Testing"
    python manage.py test --parallel
else 
    python manage.py test
fi