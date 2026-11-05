#!/bin/bash
set -euo pipefail

LOCK=/run/helios-watchauth.lock

exec 9>"$LOCK"

if ! flock -n 9 ; then
    exit 2
fi

logger -t helios-watch-auth "Execution du controle SSH"

exit 0
