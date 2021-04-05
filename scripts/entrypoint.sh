#!/bin/bash
export SETTINGS_FILE="${GITHUB_WORKSPACE}/$1/settings.py"
PARALLEL=$2

service postgresql start

# Setup database
python add_psql.py
echo "Added postgres config to your settings file"

pip install -r requirements.txt
echo "Migrating DB"
python manage.py migrate

echo "Running your tests"
if [ $PARALLEL ]; then
    echo "Enabled Parallel Testing"
    python manage.py test --parallel
else 
    python manage.py test
fi