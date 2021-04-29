#!/usr/bin/env bash
set -e

get_var_or_file(){
  var_name=$1
  file_name=$1_FILE
  if [ -n "${!file_name}" ]
  then
    cat "${!file_name}"
  elif [ -n "${!var_name}" ]
  then
    echo "${!var_name}"
  else
    if [ -n "$2" ]
    then
      echo "$2"
    else
      echo "${var_name}" nor "${file_name}" environment variables are set. exiting > /dev/stderr
      exit 1
    fi
  fi
}

DB_PORT=$(get_var_or_file DB_PORT 5432)
DB_HOST=$(get_var_or_file DB_HOST)
DB_NAME=$(get_var_or_file DB_DATABASE)
DB_PASSWORD=$(get_var_or_file DB_PASSWORD)
DB_USER=$(get_var_or_file DB_USER)


echo flyway.locations=filesystem:sql > /flyway/conf/flyway.conf
echo flyway.url=jdbc:postgresql://"${DB_HOST}":"${DB_PORT}"/"${DB_NAME}" >> /flyway/conf/flyway.conf
echo flyway.password="${DB_PASSWORD}" >> /flyway/conf/flyway.conf
echo flyway.user="${DB_USER}" >> /flyway/conf/flyway.conf
echo flyway.baselineOnMigrate=true >> /flyway/conf/flyway.conf


if [ "${REPAIR}" = "true" ]; then
  flyway repair
fi

flyway migrate

set +e

curl -X POST http://localhost:15020/quitquitquit

exit 0
