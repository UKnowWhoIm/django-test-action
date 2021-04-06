#!/bin/bash
set -e

export SETTINGS_FILE="${GITHUB_WORKSPACE}/$1/settings.py"
export SHELL_FILE_NAME="set_env.sh"
export ENV_FILE_NAME=$4
export DATABASE_URL=postgresql://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME

service postgresql start

# Setup database
python /modify_settings.py
echo "Added postgres config to your settings file"

# Setup user environment vars
if [[ ! -z $ENV_FILE_NAME ]]; then
    echo "Setting up your environment variables"
    python /setup_env_script.py
    . ./$SHELL_FILE_NAME
fi

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