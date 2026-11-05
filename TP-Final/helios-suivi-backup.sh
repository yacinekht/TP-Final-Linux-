#!/usr/bin/bash

set -euo pipefail
IFS=$'\n\t'

readonly DEST=/srv/helios/archives/suivi
readonly LOCK=/srv/helios/archives/helios-suivi-backup.lock
readonly TAG=helios-suivi-backup

log() {
    logger -t "$TAG" -p "daemon.${1}" -- "$2"
}

die() {
    log err "$1"
    exit "${2:-1}"
}

cleanup() {
    local rc=$?
    [[ -n "${TMPDIR:-}" && -d "${TMPDIR}" ]] && rm -rf -- "$TMPDIR"
    log info "fin execution rc=${rc}"
}

trap cleanup EXIT
trap 'die "interrompu par signal" 1' INT TERM

exec 9>"$LOCK"

flock -n 9 || {
    log warning "une autre instance tourne deja"
    exit 2
}

[[ -w "$DEST" ]] || die "destination non accessible" 3

stamp="$(date +%Y%m%d-%H%M%S)"

archive="${DEST}/suivi-${stamp}.tar.gz"
checksum="${archive}.sha256"

tar --acls --xattrs -czf "$archive" \
    /srv/helios/suivi \
    /etc/systemd/system/helios-suivi.service \
    /etc/systemd/system/helios-suivi-publish.service \
    /etc/systemd/system/helios-suivi-publish.timer \
    /etc/sudoers.d/90-helios-suivi \
    /etc/zabbix/zabbix_agent2.d/helios-suivi.conf \
    /usr/local/sbin/helios-suivi-publish.sh \
    /usr/local/sbin/helios-collect.sh

( cd "$DEST" && sha256sum "$(basename "$archive")" > "$(basename "$checksum")" )

(
cd "$DEST"
sha256sum -c "$(basename "$checksum")"
)

ls -1t "${DEST}"/suivi-*.tar.gz 2>/dev/null | tail -n +8 | xargs -r rm -f
ls -1t "${DEST}"/suivi-*.tar.gz.sha256 2>/dev/null | tail -n +8 | xargs -r rm -f

log info "archive creee : $archive"

exit 0
