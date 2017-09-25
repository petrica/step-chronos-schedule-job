#!/bin/sh

if [ -z $WERCKER_CHRONOS_SCHEDULE_JOB_JSON_FILE ]; then
  fail "You must specify a JSON file to deploy"
fi

if [ -z $WERCKER_CHRONOS_SCHEDULE_JOB_CHRONOS_URL ]; then
  fail "You must specify a valid chronos URL"
fi

CHRONOS_USER_ARGS=""

if [ $WERCKER_CHRONOS_SCHEDULE_JOB_HTTP_CREDENTIALS ]; then
  CHRONOS_USER_ARGS="-u $WERCKER_CHRONOS_SCHEDULE_JOB_HTTP_CREDENTIALS"
fi

CHRONOS_ENDPOINT="$WERCKER_CHRONOS_SCHEDULE_JOB_CHRONOS_URL/v1/scheduler/iso8601"
echo "Chronos Endpoint: $CHRONOS_ENDPOINT"
info "deploying $WERCKER_CHRONOS_SCHEDULE_JOB_JSON_FILE"
cat $WERCKER_CHRONOS_SCHEDULE_JOB_JSON_FILE

info "\nScheduling job"

if ! curl --fail --write-out "\n\nStatus code: %{http_code}\n" $CHRONOS_USER_ARGS -H "Content-type: application/json" -X POST -d @$WERCKER_CHRONOS_SCHEDULE_JOB_JSON_FILE $CHRONOS_ENDPOINT; then
  fail "unable to schedule job"
fi

success "\nScheduled successful"