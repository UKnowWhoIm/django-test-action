import os

PSQL_CONFIG = '''

DATABASES[\"default\"] = {
    \"ENGINE\": \"django.db.backends.postgresql_psycopg2\",
    \"NAME\": \"%s\",
    \"USER\": \"%s\",
    \"PASSWORD\": \"%s\",
    \"HOST\": \"%s\",
    \"PORT\": \"%s\",
}
'''

if __name__ == "__main__":
    settings_file = os.environ.get("SETTINGS_FILE")
    
    if not settings_file:
        raise Exception("ERROR: Settings file missing")

    with open(settings_file, "a") as f:
        f.write(
            PSQL_CONFIG % (
                os.environ.get("DB_NAME"),
                os.environ.get("DB_USER"),
                os.environ.get("DB_PASSWORD"),
                os.environ.get("DB_HOST"),
                os.environ.get("DB_PORT"),
            )
        )