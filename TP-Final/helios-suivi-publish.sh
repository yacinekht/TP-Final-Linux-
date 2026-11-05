#!/usr/bin/bash

set -euo pipefail
IFS=$'\n\t'

readonly SRC=/var/lib/helios/telemetry.csv
readonly WWW=/srv/helios/suivi/www
readonly JSON="${WWW}/etat.json"
readonly LOCK=/srv/helios/suivi/helios-suivi-publish.lock
readonly TAG=helios-suivi-publish

log() {
    logger -t "$TAG" -p "daemon.${1}" -- "$2"
}

die() {
    log err "$1"
    exit "${2:-1}"
}

cleanup() {
    local rc=$?
    [[ -n "${TMPFILE:-}" && -f "${TMPFILE}" ]] && rm -f -- "$TMPFILE"
    log info "fin execution rc=${rc}"
}

trap cleanup EXIT
trap 'die "interrompu par signal" 1' INT TERM

exec 9>"$LOCK"

flock -n 9 || {
    log warning "une autre instance tourne deja"
    exit 2
}

[[ -r "$SRC" ]] || die "telemetrie illisible : $SRC" 3
[[ -d "$WWW" ]] || die "repertoire absent : $WWW" 3
[[ -w "$WWW" ]] || die "www non inscriptible : $WWW" 3

LAST="$(tail -n 1 "$SRC")"
[[ -n "$LAST" ]] || die "telemetrie vide" 1

IFS=',' read -r derniere_mesure charge_1min mem_dispo_ko <<< "$LAST"

mesures=$(wc -l < "$SRC")
hote=$(hostname -s)

TMPFILE="$(mktemp "${WWW}/.etat.json.XXXXXX")"

cat > "$TMPFILE" <<EOFJSON
{
  "genere": "$(date --iso-8601=seconds)",
  "hote": "$hote",
  "derniere_mesure": "$derniere_mesure",
  "charge_1min": "$charge_1min",
  "mem_dispo_ko": "$mem_dispo_ko",
  "mesures": $mesures
}
EOFJSON

mv -f "$TMPFILE" "$JSON"

log info "etat.json publie"

exit 0
