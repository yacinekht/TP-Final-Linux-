systemd-analyze plot >/root/boot-avant.svg
cd /root/boot-avant.svg
cd /root
ls 
cat boot-avant.svg
systemctl disable NetworkManager-wait-online.service
systemctl disable firewalld
systemctl mask NetworkManager-wait-online.service
systemctl reboot
systemd-analyze 
systemd-analyze plot > /root/boot-apres.svg
install -d -m 0755 /usr/local/sbin /var/lib/helios /var/log/helios
cat > /usr/local/sbin/helio-collect.sh <<'EOF'
#!/usr/bin/bash
#Collecteur de telemetrie Helios - boucle longue duree
set -euo pipefail
INTERVAL="${HELIOS_INTERVAL:-15}"
OUT=/var/lib/helios/telemetry.csv
while :; do
printf'%s,%s,%s\n' "$(date --iso-8601=seconds)" \
"$(awk '{prnt $1}' /proc/loadavg)" \
"$(awk '/MemAvailable/ {print $2}' /proc/meminfo)" >> "$OUT"
sleep "$INTERVAL"
done
EOF

chmod 0755 /usr/local/sbin/helio-collect.sh
useradd --system --shell /sbin/nologin --home-dir /var/lib/helios helios
chown -R helios:helios /var/lib/helios /var/log/helios
cat >/etc/systemd/system/helios-collect.service <<'EOF'
ip config
ip
ipconfig
ip a
sudo poweroff
SYSTEMD_EDITOR=vi systemctl edit helios-collect.service
systemctl restart helios-collect.service
systemctl show -p CPUQuotaPerSecUSec -p MemoryMax -p Nice helios-collect.service
systemd-cgls /system.slice/helios-collect.service ; systemd-cgtop --iterations=3
cat > /etc/systemd/system/helios.target <<'EOF'
[Unit]
Description=Pile applicative Helios
Requires=multi-user.target
After=multi-user.target
AllowIsolate=no
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl add-wants helios.target helios-collect.service
systemctl enable helios.target ; systemctl list-dependencies helios.target
systemctl stop helios.target && systemctl start helios.target
nice -n 19 sha256sum /dev/zero & NPID=$!
ps -o pid,ni,pri,cls,rtprio,comm -p "$NPID"
renice -n 5 -p "$NPID" ; ionice -c 2 -n 7 -p "$NPID" ; ionice -p "$NPID" ; chrt -p
"$NPID"
kill "$NPID"
ip -br link
mcli con add type bond con-name bond0 ifname bond0  bond.options "mode=active-backup,miimon=100,primary=enp0s9,fail_over_mac=active"  ipv4.method manual ipv4.addresses 10.42.0.10/24 ipv4.never-default yes ipv6.method
disabled
nmcli con add type bond con-name bond0 ifname bond0 bond.options "mode=active-backup,miimon=100,primary=enp0s9,fail_over_mac=active"  ipv4.method manual ipv4.addresses 10.42.0.10/24 ipv4.never-default yes ipv6.method
disabled
[200~nmcli con add type bond con-name bond0 ifname bond0 \
nmcli con add type bond con-name bond0 ifname bond0 \
disabled
nmcli con add type bond con-name bond0 ifname bond0 bond.options "mode=active-backup,miimon=100,primary=enp0s9,fail_over_mac=active" ipv4.method manual ipv4.addresses 10.42.0.10/24 ipv4.never-default yes ipv6.method disabled
nmcli con add type ethernet con-name bond0-p1 ifname enp0s9 master bond0
nmcli con add type ethernet con-name bond0-p2 ifname enp0s10 master bond0
[200~nmcli con up bond0 ; nmcli con up bond0-p1 ; nmcli con up bond0-p2
nmcli con up bond0 ; nmcli con up bond0-p1 ; nmcli con up bond0-p2
cat /proc/net/bonding/bond0 ; ip -d link show bond0
VBoxManage controlvm srv-core setlinkstate3 off VBoxManage controlvm srv-core setlinkstate3 off 
VBoxManage controlvm srv-core setlinkstate3 off
grep -E 'Active Slave|MII Status' /proc/net/bonding/bond0
journalctl -k -n 20 --no-pager | grep -i bond
nmcli con add type vlan con-name bond0.42 ifname bond0.42 dev bond0 id 42 \
ipv4.method manual ipv4.addresses 10.42.42.10/24 ipv4.never-default yes ipv6.method
nmcli con add type vlan con-name bond0.42 ifname bond0.42 dev bond0 id 42 \
ipv4.method manual ipv4.addresses 10.42.42.10/24 ipv4.never-default yes ipv6.method disabled
nmcli con add type vlan con-name bond0.42 ifname bond0.42 dev bond0 id 42 \
ipv4.method manual ipv4.addresses 10.42.42.10/24 ipv4.never-default yes ipv6.method
disabled
nmcli con add type vlan con-name bond0.42 ifname bond0.42 dev bond0 id 42 ipv4.method manual ipv4.addresses 10.42.42.10/24 ipv4.never-default yes ipv6.method disabled
nmcli con up bond0.42
nmcli con up bond0.42 ; ip -d link show bond0.42 | grep -A1 vlan
nmcli con show bond0.42
nmcli con mod bond0.42 ipv4.method manual
nmcli con mod bond0.42 ipv4.addresses 10.42.42.10/24
nmcli con mod bond0.42 ipv4.method manual
nmcli con show | grep bond0.42
nmcli con delete a23de7e8-015d-4e0b-a82d-a77195070505
nmcli con delete 9180f84e-e2a8-47aa-8dfc-4c6fd264d379
nmcli con delete b36ccaa1-8e92-45a7-ac54-56e020ad2840
nmcli con up bond0.42 ; ip -d link show bond0.42 | grep -A1 vlan
dnf -y install tcpdump
tcpdump -nei bond0 -c 5 'vlan 42' & ping -c 5 10.42.42.11
grep -qs '^142' /etc/iproute2/rt_tables || echo '142 transport' >>
/etc/iproute2/rt_tables
grep -qs '^142' /etc/iproute2/rt_tables || echo '142 transport' >> /etc/iproute2/rt_tables
nmcli con mod bond0.42 +ipv4.routes "0.0.0.0/0 10.42.42.11 table=142" +ipv4.routing-rules "priority 100 from 10.42.42.10/32 table 142"
nmcli con up bond0.42
ip rule show ; ip route show table transport
ip route get 8.8.8.8 from 10.42.42.10
ip route get 8.8.8.8 
cat > /usr/local/sbin/helios-archive.sh <<'EOF'

#!/usr/bin/bash
# helios-archive.sh — archive la telemetrie du jour, purge au-dela de 14 jours.
# Sortie : 0 OK · 1 erreur interne · 2 verrou deja pris · 3 prerequis manquant
set -euo pipefail
IFS=$'\n\t'
readonly SRC=/var/lib/helios/telemetry.csv
readonly DEST=/var/lib/helios/archives
readonly RETENTION_DAYS=14
readonly LOCK=/run/lock/helios-archive.lock
readonly TAG=helios-archive
log() { logger -t "$TAG" -p "daemon.${1}" -- "$2" ; }
die() { log err "$1" ; exit "${2:-1}" ; }
cleanup() { local rc=$? ; [[ -n "${TMPD:-}" ]] && rm -rf -- "$TMPD"
 log info "fin d execution rc=${rc}" ; return 0 ; }
trap cleanup EXIT
trap 'die "interrompu par signal" 1' INT TERM
exec 9>"$LOCK" # verrou exclusif non bloquant
flock -n 9 || { log warning "une autre instance tourne deja" ; exit 2 ; }
command -v gzip >/dev/null || die "gzip absent" 3
[[ -r "$SRC" ]] || die "source illisible : $SRC" 3
log info "demarrage"
install -d -m 0750 -o helios -g helios "$DEST"
TMPD="$(mktemp -d /tmp/helios-archive.XXXXXX)"
stamp="$(date +%Y%m%d-%H%M%S)"
cp -- "$SRC" "${TMPD}/telemetry-${stamp}.csv"
: > "$SRC"
gzip -9 -- "${TMPD}/telemetry-${stamp}.csv"
install -m 0640 -o helios -g helios \
 "${TMPD}/telemetry-${stamp}.csv.gz" "${DEST}/telemetry-${stamp}.csv.gz"
log info "archive ${DEST}/telemetry-${stamp}.csv.gz ($(zcat
"${DEST}/telemetry-${stamp}.csv.gz" | wc -l) lignes)"
purged=$(find "$DEST" -type f -name 'telemetry-*.csv.gz' -mtime "+${RETENTION_DAYS}" -
printf . -delete | wc -c)
log info "purge : ${purged} archive(s) supprimee(s)"
exit 0
EOF

chmod 0750 /usr/local/sbin/helios-archive.sh
/usr/local/sbin/helios-archive.sh ; echo "rc=$?"
journalctl -t helios-archive -n 10 --no-pager
( exec 9>/run/lock/helios-archive.lock ; flock 9 ; sleep 20 ) &
sleep 1 ; /usr/local/sbin/helios-archive.sh ; echo "rc attendu 2 -> $?" ; wait
mv /var/lib/helios/telemetry.csv /tmp/t.csv
/usr/local/sbin/helios-archive.sh ; echo "rc attendu 3 -> $?"
mv /tmp/t.csv /var/lib/helios/telemetry.csv
ls -l /var/lib/helios/
mkdir -p /var/lib/helios
echo "2026-11-03T15:00:00,0.12,3983024" > /var/lib/helios/telemetry.csv
/usr/local/sbin/helios-archive.sh
echo "rc=$?"
mv /tmp/t.csv /var/lib/helios/telemetry.csv
mv /var/lib/helios/telemetry.csv /tmp/t.csv
/usr/local/sbin/helios-archive.sh ; echo "rc attendu 3 -> $?"
mv /tmp/t.csv /var/lib/helios/telemetry.csv
cat > /etc/systemd/system/helios-archive.service <<'EOF'
[Unit]
Description=Archivage de la telemetrie Helios
ConditionPathExists=/var/lib/helios/telemetry.csv
[Service]
Type=oneshot
ExecStart=/usr/local/sbin/helios-archive.sh
Nice=10
IOSchedulingClass=idle
EOF

cat > /etc/systemd/system/helios-archive.timer <<'EOF'
[Unit]
Description=Declenche l archivage de la telemetrie Helios
[Timer]
OnCalendar=*-*-* 02:30:00
AccuracySec=1min
RandomizedDelaySec=120
Persistent=yes
Unit=helios-archive.service
[Install]
WantedBy=timers.target
EOF

systemctl daemon-reload && systemctl enable --now helios-archive.timer
systemd-analyze calendar '*-*-* 02:30:00' --iterations=3
systemctl list-timers helios-archive.timer --all --no-pager
systemctl start helios-archive.service && systemctl status helios-archive.service --nopager
dnf -y install cronie && systemctl enable --now crond
printf 'MAILTO=""\n30 2 * * * root /usr/local/sbin/helios-archive.sh\n' >
/etc/cron.d/helios-legacy
printf 'MAILTO=""\n30 2 * * * root /usr/local/sbin/helios-archive.sh\n' > /etc/cron.d/helios-legacy
systemctl restart crond ; journalctl -u crond -n 10 --no-pager
rm -f /etc/cron.d/helios-legacy && systemctl restart crond
sudo dnf install git -y
git config --global user.name "Yacine KHIAT"
git config --global user.email "yacine.khiat8@gmail.com"
mkdir ~/tp-linux
cd ~/tp-linux
cp /usr/local/sbin/helios-collect.sh .
ls -l /usr/local/sbin/
cp /usr/local/sbin/helio-collect.sh .
cp /usr/local/sbin/helios-archive.sh .
cp /etc/systemd/system/helios-collect.service .
cp /etc/systemd/system/helios-archive.service .
cp /etc/systemd/system/helios-archive.timer .
cp /etc/systemd/system/helios.target .
git init
git add .
git commit -m "TP1 Linux Helios"
git remote add origin https://github.com/yacinekht/TP1-linux.git
git branch -M main
git push -u origin main
ssh-keygen -t ed25519 -C "yacine.khiat8@gmail.com"
cat ~/.ssh/id_ed25519.pub
ssh-keygen -t ed25519 -C "yacine.khiat8@gmail.com"
git push -u origin main
ls ~/.ssh
ssh-keygen -t ed25519 -C "yacine.khiat8@gmail.com" -f ~/.ssh/id_ed25519 -N ""
ls ~/.ssh
cat ~/.ssh/id_ed25519.pub
git remote set-url origin git@github.com:yacinekht/TP1-linux.git
ssh -T git@github.com
git push -u origin main
mkdir -p /etc/security/pwquality.conf.d
cp /tmp/50-helios.conf /etc/security/pwquality.conf.d/50-helios.conf
scp annexes/50-helios.conf annexes/skel-bashrc.ajout annexes/helios-umask.sh annexes/helios-lastlog.c annexes/90-helios-ops sysops@192.168.56.10:/tmp/
cp /tmp/50-helios.conf /etc/security/pwquality.conf.d/50-helios.conf
cat /tmp/skel-bashrc.ajout >> /etc/skel/.bashrc
cp /tmp/50-helios.conf /etc/security/pwquality.conf.d/50-helios.conf
ls -l /tmp
ls /tmp
cat > /etc/security/pwquality.conf.d/50-helios.conf <<'EOF'
cp -a /etc/login.defs /root/login.defs.orig
sed -i -e 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 90/' -e 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS
1/' -e 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 14/' -e 's/^UMASK.*/UMASK 027/'
/etc/login.defs
-e 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 14/' -e 's/^UMASK.*/UMASK 027/' /etc/login.defs
cp -a /etc/login.defs /root/login.defs.orig
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 90/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 1/' /etc/login.defs
sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 14/' /etc/login.defs
sed -i 's/^UMASK.*/UMASK 027/' /etc/login.defs
grep -E '^(PASS_|UMASK|USERGROUPS_ENAB|CREATE_HOME)' /etc/login.defs
diff /root/login.defs.orig /etc/login.defs
grep -E '^(PASS_|UMASK|USERGROUPS_ENAB|CREATE_HOME)' /etc/login.defs
cat > /etc/security/pwquality.conf.d/50-helios.conf <<'EOF'
minlen = 12
minclass = 3
maxrepeat = 3
dictcheck = 1
usercheck = 1
enforce_for_root
EOF

authselect current ; authselect enable-feature with-faillock
sed -i -e 's/^# *deny *=.*/deny = 5/' 
authselect list
authselect select sssd with-faillock --force
authselect current
authselect current ; authselect enable-feature with-faillock
-e 's/^# *deny *=.*/deny = 5/' -e 's/^# *unlock_time *=.*/unlock_time = 600/'  -e 's/^# *fail_interval *=.*/fail_interval = 900/' -e 's/^# *audit$/audit/'  /etc/security/faillock.conf
sed -i -e 's/^# *deny *=.*/deny = 5/' -e 's/^# *unlock_time *=.*/unlock_time = 600/' -e 's/^# *fail_interval *=.*/fail_interval = 900/' \
sed -i -e 's/^# *deny *=.*/deny = 5/' -e 's/^# *unlock_time *=.*/unlock_time = 600/' -e 's/^# *fail_interval *=.*/fail_interval = 900/' -e 's/^# *audit$/audit/' /etc/security/faillock.conf
grep -Ev '^\s*(#|$)' /etc/security/faillock.conf
cat >> /etc/skel/.bashrc <<'EOF'

# socle Helios (pas de umask ici : ~/.bashrc est lu APRÈS /etc/profile.d et écraserait
# le umask par groupe de la Mission 2 ; le 027 de base vient de login.defs via pam_umask)
export EDITOR=vim HISTSIZE=5000 HISTTIMEFORMAT='%F %T '

EOF

groupadd -g 5000 transport
groupadd -g 5001 telemetry
groupadd -g 5002 helios-ops 
useradd -u 5100 -g transport -G helios-ops -c "Julien Marty - chef equipe transport" -m julien
useradd -u 5101 -g transport -c "Nadia Belkacem - exploitante" -m nadia
useradd -u 5102 -g telemetry -G transport -c "Tarek Oualid - analyste telemetrie" -m tarek
useradd -u 5103 -g telemetry -c "Auditeur externe - mandat Q4" -m  -e "$(date -d '+21 days' +%F)" -s /bin/bash audit-ext
for u in julien nadia tarek audit-ext ; do  echo "${u}:Helios-TP2-2026" | chpasswd;  chage -M 90 -m 1 -W 14 -I 7 "$u"; done
chage -l julien
getent passwd julien nadia tarek audit-ext ; getent group transport telemetry helios-ops
gpasswd -A julien transport
grep '^transport' /etc/group /etc/gshadow
su - julien -c 'gpasswd -a nadia transport ; id nadia'
grep '^transport' /etc/group /etc/gshadow
chage -d "$(date -d yesterday +%F)" julien
su - julien -c 'gpasswd -a nadia transport ; id nadia'
id julien
su - julien
install -d -m 0755 /srv/helios/projets
install -d -m 2770 -o julien -g transport /srv/helios/projets/transport
install -d -m 0770 -o julien -g transport /srv/helios/projets/temoin
ls -ld /srv/helios/projets/transport /srv/helios/projets/temoin
su - nadia -c 'touch /srv/helios/projets/transport/tournee-nadia.csv
/srv/helios/projets/temoin/x ;
 ls -l /srv/helios/projets/transport/ /srv/helios/projets/temoin/'
su - nadia -c 'touch /srv/helios/projets/transport/tournee-nadia.csv /srv/helios/projets/temoin/x ; ls -l /srv/helios/projets/transport/ /srv/helios/projets/temoin/'
getent nadia
id nadira
id nadia
su - tarek -c 'touch /srv/helios/projets/transport/tournee-tarek.csv /srv/helios/projets/temoin/y ; ls -l /srv/helios/projets/transport/tournee-tarek.csv /srv/helios/projets/temoin/y'
id tarek
install -d -m 1777 /srv/helios/depot ; ls -ld /srv/helios/depot
su - nadia -c 'echo n > /srv/helios/depot/fichier-nadia'
su - tarek -c 'rm -f /srv/helios/depot/fichier-nadia' ; echo "rc attendu != 0 : $?"
chmod 0777 /srv/helios/depot
su - tarek -c 'rm -f /srv/helios/depot/fichier-nadia' ; echo "rc attendu 0 : $?"
chmod 1777 /srv/helios/depot
su - nadia -c 'umask ; touch /tmp/u1 ; mkdir /tmp/d1 ; ls -ld /tmp/u1 /tmp/d1'
su - nadia -c 'umask 002 ; touch /tmp/u2 ; mkdir /tmp/d2 ; ls -ld /tmp/u2 /tmp/d2'
su - nadia -c 'umask 077 ; touch /tmp/u3 ; ls -l /tmp/u3'
cat > /etc/profile.d/helios-umask.sh <<'EOF'
# umask 002 pour les membres de transport (travail collaboratif setgid), 027 sinon.
if id -nG | tr ' ' '\n' | grep -qx transport ; then umask 002 ; else umask 027 ; fi
EOF

chmod 0644 /etc/profile.d/helios-umask.sh
su - nadia -c 'umask ; touch /srv/helios/projets/transport/partage.txt ;
 ls -l /srv/helios/projets/transport/partage.txt'
su - audit-ext -c 'umask'
find / -xdev \( -perm -4000 -o -perm -2000 \) -type f -printf '%M %u %g %p\n' 2>/dev/null
| sort
printf '#!/usr/bin/bash\nid\n' > /usr/local/bin/faux-setuid.sh
chmod 4755 /usr/local/bin/faux-setuid.sh
su - nadia -c '/usr/local/bin/faux-setuid.sh'
rm -f /usr/local/bin/faux-setuid.sh
install -m 0640 -o root -g telemetry /dev/null /var/log/helios/app.log
for i in $(seq 1 30); do echo "$(date --iso-8601=seconds) INFO trame ${i} ok" >>
/var/log/helios/app.log ; done
for i in $(seq 1 30); do echo "$(date --iso-8601=seconds) INFO trame ${i} ok" >> /var/log/helios/app.log ; done
cat > /root/helios-lastlog.c <<'EOF'
/* helios-lastlog : affiche la fin du journal applicatif Helios.
* Installe setgid telemetry : l'egid permet la lecture, l'uid reste l'appelant.
* Environnement et chemin figes pour eviter toute injection via PATH/IFS. */
#include <unistd.h>
#include <stdio.h>
int main(void)
{
 char *env[] = { "PATH=/usr/bin:/bin", "IFS= \t\n", NULL };
 execle("/usr/bin/tail", "tail", "-n", "10",
 "/var/log/helios/app.log", (char *)NULL, env);
 perror("execle");
return 1;
}
EOF

gcc -O2 -Wall -Wextra -o /usr/local/bin/helios-lastlog /root/helios-lastlog.c
dnf groupinstall "Development Tools"
gcc -O2 -Wall -Wextra -o /usr/local/bin/helios-lastlog /root/helios-lastlog.c
gcc --version
gcc -O2 -Wall -Wextra -o /usr/local/bin/helios-lastlog /root/helios-lastlog.c
chown root:telemetry /usr/local/bin/helios-lastlog
chmod 2755 /usr/local/bin/helios-lastlog ; ls -l /usr/local/bin/helios-lastlog
su - julien -c 'tail -n 3 /var/log/helios/app.log' ; echo "rc attendu != 0 : $?"
su - julien -c '/usr/local/bin/helios-lastlog' ; echo "rc attendu 0 : $?"
getfacl /srv/helios/projets/transport
setfacl -R -m u:audit-ext:rX /srv/helios/projets/transport
getfacl /srv/helios/projets/transport
ls -ld /srv/helios/projets/transport
 -l /srv/helios/projets/transport/ ;
 cat /srv/helios/projets/transport/tournee-nadia.csv'
su - audit-ext -c 'ls -l /srv/helios/projets/transport/ ; 
cat /srv/helios/projets/transport/tournee-nadia.csv'
su - audit-ext -c 'touch /srv/helios/projets/transport/interdit' ; echo "rc attendu != 0
: $?"
su - nadia -c 'touch /srv/helios/projets/transport/nouvelle.csv'
su - audit-ext -c 'cat /srv/helios/projets/transport/nouvelle.csv' ; echo "rc=$?"
setfacl -d -m u:audit-ext:r /srv/helios/projets/transport
setfacl -d -m g:transport:rwx /srv/helios/projets/transport
setfacl -d -m o::--- /srv/helios/projets/transport
getfacl /srv/helios/projets/transport
su - nadia -c 'touch /srv/helios/projets/transport/tournee-j2.csv ;
 mkdir -p /srv/helios/projets/transport/semaine-41'
getfacl /srv/helios/projets/transport/tournee-j2.csv
getfacl /srv/helios/projets/transport/semaine-41
su - audit-ext -c 'cat /srv/helios/projets/transport/tournee-j2.csv' ; echo "rc attendu 0
: $?"
setfacl -m u:tarek:rwx /srv/helios/projets/transport/tournee-j2.csv
getfacl /srv/helios/projets/transport/tournee-j2.csv
chmod g-w /srv/helios/projets/transport/tournee-j2.csv
getfacl /srv/helios/projets/transport/tournee-j2.csv
su - tarek -c 'echo x >> /srv/helios/projets/transport/tournee-j2.csv' ; echo "rc=$?"
setfacl -m m::rwx /srv/helios/projets/transport/tournee-j2.csv
su - tarek -c 'echo x >> /srv/helios/projets/transport/tournee-j2.csv' ; echo "rc attendu
0 : $?"
cd /srv/helios/projets
getfacl -R transport > /root/acl-transport-$(date +%F).txt
setfacl -R -b transport ; getfacl transport | head
setfacl --restore=/root/acl-transport-$(date +%F).txt ; getfacl transport | head
cp -a transport transport-copie && getfacl transport-copie | head
cp -r transport transport-copie2 && getfacl transport-copie2 | head
tar --acls --xattrs -czf /root/transport.tgz transport
tar --acls --xattrs -tvf /root/transport.tgz | head -3
rm -rf transport-copie transport-copie2
cat > /etc/sudoers.d/90-helios-ops <<'EOF'
# Delegation Helios - equipe exploitation applicative
Cmnd_Alias HELIOS_SVC = /usr/bin/systemctl start helios-collect.service, \
 /usr/bin/systemctl stop helios-collect.service, \
/usr/bin/systemctl restart helios-collect.service, \
/usr/bin/systemctl status helios-collect.service, \
/usr/bin/systemctl start helios.target, \
/usr/bin/systemctl stop helios.target
Cmnd_Alias HELIOS_LOG = /usr/bin/journalctl -u helios-collect.service *, \
 /usr/bin/journalctl -u helios-archive.service *
Cmnd_Alias DANGEREUX = /usr/bin/su, /usr/bin/sudo, /usr/bin/passwd root, \
 /usr/bin/vi, /usr/bin/vim, /usr/bin/less, /usr/bin/find
Defaults:%helios-ops timestamp_timeout=5, passwd_tries=2, lecture=always
Defaults:%helios-ops log_output, iolog_dir=/var/log/sudo-io
Defaults:%helios-ops logfile=/var/log/sudo-helios.log
%helios-ops ALL = (root) HELIOS_SVC, HELIOS_LOG
%helios-ops ALL = (helios) /usr/bin/ls /var/lib/helios, /usr/bin/cat
/var/lib/helios/telemetry.csv
%helios-ops ALL = !DANGEREUX
EOF

chmod 0440 /etc/sudoers.d/90-helios-ops
visudo -cf /etc/sudoers.d/90-helios-ops
cat > /etc/sudoers.d/90-helios-ops <<'EOF'
# Delegation Helios - equipe exploitation applicative
Cmnd_Alias HELIOS_SVC = /usr/bin/systemctl start helios-collect.service, \
 /usr/bin/systemctl stop helios-collect.service, \
/usr/bin/systemctl restart helios-collect.service, \
/usr/bin/systemctl status helios-collect.service, \
/usr/bin/systemctl start helios.target, \
/usr/bin/systemctl stop helios.target
Cmnd_Alias HELIOS_LOG = /usr/bin/journalctl -u helios-collect.service *, \
 /usr/bin/journalctl -u helios-archive.service *
Cmnd_Alias DANGEREUX = /usr/bin/su, /usr/bin/sudo, /usr/bin/passwd root, \
 /usr/bin/vi, /usr/bin/vim, /usr/bin/less, /usr/bin/find
Defaults:%helios-ops timestamp_timeout=5, passwd_tries=2, lecture=always
Defaults:%helios-ops log_output, iolog_dir=/var/log/sudo-io
Defaults:%helios-ops logfile=/var/log/sudo-helios.log
%helios-ops ALL = (root) HELIOS_SVC, HELIOS_LOG
%helios-ops ALL = (helios) /usr/bin/ls /var/lib/helios, /usr/bin/cat
/var/lib/helios/telemetry.csv
%helios-ops ALL = !DANGEREUX
EOF

cat > /etc/sudoers.d/90-helios-ops <<'EOF'
install -d -m 0700 /var/log/sudo-io
sudo -l -U julien
su - julien -c 'sudo systemctl restart helios-collect.service'
su - julien -c 'sudo systemctl restart sshd' 
cat > /etc/sudoers.d/90-helios-ops <<'EOF'
# Delegation Helios - equipe exploitation applicative

Cmnd_Alias HELIOS_SVC = \
    /usr/bin/systemctl start helios-collect.service, \
    /usr/bin/systemctl stop helios-collect.service, \
    /usr/bin/systemctl restart helios-collect.service, \
    /usr/bin/systemctl status helios-collect.service, \
    /usr/bin/systemctl start helios.target, \
    /usr/bin/systemctl stop helios.target

Cmnd_Alias HELIOS_LOG = \
    /usr/bin/journalctl -u helios-collect.service *, \
    /usr/bin/journalctl -u helios-archive.service *

Cmnd_Alias DANGEREUX = \
    /usr/bin/su, \
    /usr/bin/sudo, \
    /usr/bin/passwd root, \
    /usr/bin/vi, \
    /usr/bin/vim, \
    /usr/bin/less, \
    /usr/bin/find

Defaults:%helios-ops timestamp_timeout=5,passwd_tries=2
Defaults:%helios-ops log_output,iolog_dir=/var/log/sudo-io
Defaults:%helios-ops logfile=/var/log/sudo-helios.log

%helios-ops ALL = (root) HELIOS_SVC, HELIOS_LOG
%helios-ops ALL = (helios) /usr/bin/ls /var/lib/helios, /usr/bin/cat /var/lib/helios/telemetry.csv

%helios-ops ALL = !DANGEREUX
EOF

visudo -cf /etc/sudoers.d/90-helios-ops
sudo -l -U julien
su - julien -c 'sudo systemctl restart helios-collect.service' 
su - julien -c 'sudo systemctl restart sshd'
su - julien -c 'sudo -u helios cat /var/lib/helios/telemetry.csv | tail -3'
git init
git commit -m " TP2 linux "
git add .
git commit -m " TP2 linux "
git remote add origin https://github.com/yacinekht/TP2-linux.git
git push -u origin main
git branch
git push -u origin master
git remote -v
git remote remove origin
git remote add origin git@github.com:yacinekht/TP2-linux.git
git remote -v
ssh -T git@github.com
git push -u origin master
systemctl unmask firewalld 2>/dev/null ; systemctl enable --now firewalld
firewall-cmd --state ; firewall-cmd --get-default-zone ; firewall-cmd --get-active-zones
nmcli -g NAME con show | while read -r c ; do printf '%s : %s\n' "$c" "$(nmcl -g connection.zone con show "$c")" ; done
nmcli -g NAME con show | while read -r c ; do     printf '%s : %s\n' "$c" "$(nmcli -g connection.zone con show "$c")"; done
NATCON=$(nmcli -t -f NAME,DEVICE con show --active | awk -F: '$2=="enp0s3"{print $1}')
nmcli con mod "$NATCON" connection.zone drop
nmcli con mod admin connection.zone work
nmcli con mod enp0s8 connection.zone work
nmcli con mod bond0  connection.zone internal
nmcli -f NAME,UUID,DEVICE connection show
nmcli connection delete aaa3b610-4767-4b77-af75-82f644f9a893
nmcli con mod bond0  connection.zone internal
nmcli con mod bond0.42 connection.zone internal
for c in "$NATCON" admin bond0 bond0.42 ; do nmcli con up "$c" ; done
for c in "$NATCON" enp0s8 bond0 bond0.42 ; do nmcli con up "$c" ; done
firewall-cmd --get-active-zones
firewall-cmd --set-default-zone=drop
firewall-cmd --permanent --zone=work --remove-service=dhcpv6-client 2>/dev/null
firewall-cmd --permanent --zone=work --remove-service=cockpit 2>/dev/null 
ping 192.168.56.0/24
ping 192.168.56.0
nmcli con mod enp0s8 ipv4.method manual ipv4.addresses 192.168.56.10/24
nmcli con up enp0s8
ip a show enp0s8
firewall-cmd --reload
firewall-cmd --zone=work --list-all
firewall-cmd --permanent --zone=work --add-source=192.168.56.0/24
firewall-cmd --permanent --zone=internal --remove-service=mdns 2>/dev/null
firewall-cmd --permanent --zone=internal --remove-service=samba-client 2>/dev/null
firewall-cmd --permanent --zone=internal --remove-service=cockpit 2>/dev/null
firewall-cmd --permanent --zone=internal --remove-service=dhcpv6-client 2>/dev/null
firewall-cmd --permanent --zone=internal --add-service=ssh
firewall-cmd --permanent --zone=internal --add-port=10051/tcp
firewall-cmd --reload
firewall-cmd --zone=work --list-all ; firewall-cmd --zone=internal --list-all
tcpdump -ni enp0s8 icmp
ip route
nmcli con up enp0s8
firewall-cmd--reload
firewall-cmd --reload
firewall-cmd --zone=work --list-all
firewall-cmd --permanent --zone=work --remove-service=ssh
firewall-cmd --permanent --zone=work --add-rich-rule='rule service name="ssh log prefix="SSH-NEW " level="info" limit value="3/m" accept limit value="6/m"'
firewall-cmd --permanent --zone=work --add-rich-rule='rule service name="ssh" log prefix="SSH-NEW " level="info" limit value="3/m" accept limit value="6/m"'
ping -c 3 192.168.56.109
nmcli con up enp0s8
ping -c 3 192.168.56.109
arp -a
ping -c 3 192.168.56.109arp -a
firewall-cmd --permanent --new-ipset=helios-blacklist --type=hash:ip  --option=family=inet --option=hashsize=4096 --option=maxelem=65536
firewall-cmd --permanent --zone=work --add-rich-rule='rule source ipset="heliosblacklist" drop'
firewall-cmd --permanent --zone=work --add-rich-rule='rule source ipset="hel osblacklist" drop'
firewall-cmd --get-ipsets
firewall-cmd --permanent --new-ipset=helios-blacklist --type=hash:ip  --option=family=inet --option=hashsize=4096 --option=maxelem=65536
firewall-cmd --reload
firewall-cmd --get-ipsets
firewall-cmd --permanent --zone=work --add-rich-rule='rule source ipset="heliosblacklist" drop'
firewall-cmd --permanent --zone=work --add-rich-rule='rule source ipset="helios-blacklist" drop'
firewall-cmd --set-log-denied=unicast
firewall-cmd --check-config && firewall-cmd --reload
firewall-cmd --get-ipsets ; firewall-cmd --zone=work --list-rich-rules
ping -c 3 192.168.56.11
tcpdump -ni enp0s8 arp or icmp
nft list tables
nft list chain inet firewalld filter_IN_work
nft list set inet firewalld helios-blacklist
iptables -S | head -5 
journalctl -k -g 'SSH-NEW' -n 20 --no-pager
journalctl -k -g 'REJECT|DROP' -n 20 --no-pager
groupadd -r ssh-admins ; usermod -aG ssh-admins sysops ; usermod -aG ssh-admins julien
id sysops
tcpdump -ni enp0s8 arp or icmp
useradd sysops
passwd sysops
groupadd -r ssh-admins ; usermod -aG ssh-admins sysops ; usermod -aG ssh-admins julien
usermod -aG ssh-admins sysops ; usermod -aG ssh-admins julien
passwd sysops
for k in /etc/ssh/ssh_host_*_key.pub ; do ssh-keygen -lf "$k" ; done
ls -l /home/sysops/.ssh/authorized_keys
cat > /etc/ssh/sshd_config.d/10-helios-hardening.conf <<'EOF'
# --- Durcissement SSH Helios Logistique --- TP3 BTC2
Port 2242
AddressFamily inet
ListenAddress 192.168.56.10
ListenAddress 10.42.0.10
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
PermitEmptyPasswords no
AuthenticationMethods publickey
MaxAuthTries 3
MaxSessions 4
MaxStartups 10:30:60
LoginGraceTime 30
AllowGroups ssh-admins
X11Forwarding no
AllowAgentForwarding no
AllowTcpForwarding no
AllowStreamLocalForwarding no
PermitTunnel no
GatewayPorts no
PermitUserEnvironment no
ClientAliveInterval 300
ClientAliveCountMax 2
TCPKeepAlive no
LogLevel VERBOSE
PrintLastLog yes
Banner /etc/issue.net
Subsystem sftp internal-sftp -l INFO -f AUTHPRIV
# Exception maîtrisée : l'equipe exploitation a besoin d'un tunnel vers le port 10051
Match Group helios-ops
 AllowTcpForwarding yes
 PermitOpen localhost:10051
EOF

cat > /etc/issue.net <<'EOF'

*** Serveur Helios Logistique - acces strictement reserve ***
Toute connexion est journalisee.
EOF

sshd -t && echo "syntaxe OK"
update-crypto-policies --show ; cat /etc/ssh/sshd_config.d/50-redhat.conf | head -6
update-crypto-policies --set DEFAULT:NO-SHA1
systemctl restart sshd
systemctl status sshd.service
sshd -t
journalctl -xeu sshd.service -n 50
ip -4 addr
semanage port -l | grep ssh
semanage port -a -t ssh_port_t -p tcp 2242
semanage port -l | grep ssh
systemctl restart sshd
sshd -T | grep -iE '^(ciphers|kexalgorithms|macs|hostkeyalgorithms)' | tr ',' '\n' | head
-20

sshd -T | grep -iE '^(ciphers|kexalgorithms|macs|hostkeyalgorithms)' | tr ',' '\n' | head
-20
sshd -T | grep -iE '^(ciphers|kexalgorithms|macs|hostkeyalgorithms)' | tr ', '\n' | head -20
# (b) Approche locale : un drop-in lu AVANT 50-redhat.conf, pour comprendre le mécanisme
# (pas d'ajout en fin de 10-helios-hardening.conf : on serait dans le bloc « Match Group
»,
# et sshd -t refuse « Directive 'HostKeyAlgorithms' is not allowed within a Match block
»)
sshd -T | grep -iE '^(ciphers|kexalgorithms|macs|hostkeyalgorithms)' | tr ',' '\n' | head -20
cat > /etc/ssh/sshd_config.d/05-helios-crypto.conf <<'EOF'
HostKeyAlgorithms ssh-ed25519,rsa-sha2-512
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-
sha512
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
EOF

sshd -t && systemctl restart sshd
sshd -T | grep -iE '^(ciphers|kexalgorithms|macs)'
firewall-cmd --permanent --zone=work --add-rich-rule='rule port port="2242"
protocol="tcp" log prefix="SSH-NEW " level="info" limit value="3/m" accept limit value="6/m"'
firewall-cmd --permanent --zone=work --add-rich-rule='rule port port="2242" protocol="tcp" log prefix="SSH-NEW " level="info" limit value="3/m" accept limit value="6/m"'
firewall-cmd --permanent --zone=work --remove-rich-rule='rule service name=" sh" log prefix="SSH-NEW " level="info" limit value="3/m" accept limit value="6/m"'
firewall-cmd --permanent --zone=work --remove-rich-rule='rule service name="ssh" log prefix="SSH-NEW " level="info" limit value="3/m" accept limit value="6/m"'
firewall-cmd --permanent --zone=internal --add-port=2242/tcp
firewall-cmd --permanent --zone=internal --remove-service=ssh
firewall-cmd --reload
systemctl restart sshd ; ss -ltnp | grep sshd ; journalctl -u sshd -n 20 --no-pager
cat -n /etc/ssh/sshd_config.d/05-helios-crypto.conf
sed -i 's/diffie-hellman-group16-$/diffie-hellman-group16-sha512/' /etc/ssh/sshd_config.d/05-helios-crypto.conf
systemctl restart sshd ; ss -ltnp | grep sshd ; journalctl -u sshd -n 20 --no-pager
cat > /etc/ssh/sshd_config.d/05-helios-crypto.conf <<'EOF'
HostKeyAlgorithms ssh-ed25519,rsa-sha2-512
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
EOF

sshd -t
systemctl restart sshd
systemctl restart sshd ; ss -ltnp | grep sshd ; journalctl -u sshd -n 20 --no-pager
nc -zv -w2 192.168.56.10 22 ; echo "1. ancien port : echec attendu ($?)"
ssh -p 2242 sysops@192.168.56.10 'hostname; id -nG'
ssh -p 2242 root@192.168.56.10 'id' ; echo "3. root : echec attendu ($?)"
ssh -p 2242 -o PubkeyAuthentication=no -o PreferredAuthentications=password \sysops@192.168.56.10 ; echo "4. mot de passe : echec attendu ($?)"
ssh -p 2242 nadia@192.168.56.10 ; echo "5. hors ssh-admins : echec attendu ($?)"
ssh -p 2242 -N -L 9999:localhost:10051 sysops@192.168.56.10 & sleep 2
nc -zv -w2 127.0.0.1 9999 ; sleep 1 ; kill %1 2>/dev/null
sleep 15 
ssh -p 2242 -o KexAlgorithms=diffie-hellman-group14-sha1 sysops@192.168.56.10
echo "7. KEX SHA-1 : echec attendu ($?)"
ssh -p 2242 -o KexAlgorithms=diffie-hellman-group14-sha1 sysops@192.168.56.10echo "7. KEX SHA-1 : echec attendu ($?)"
mkdir -p /etc/systemd/journald.conf.d
cat > /etc/systemd/journald.conf.d/50-helios.conf <<'EOF
[Journal]
Storage=persistent
Compress=yes
SystemMaxUse=500M
SystemKeepFree=1G
SystemMaxFileSize=50M
MaxRetentionSec=1month
MaxFileSec=1day
RateLimitIntervalSec=30s
RateLimitBurst=10000
ForwardToSyslog=no
Seal=yes
EOF

EOF
cat > /etc/systemd/journald.conf.d/50-helios.conf <<'EOF'
[Journal]
Storage=persistent
Compress=yes
SystemMaxUse=500M
SystemKeepFree=1G
SystemMaxFileSize=50M
MaxRetentionSec=1month
MaxFileSec=1day
RateLimitIntervalSec=30s
RateLimitBurst=10000
ForwardToSyslog=no
Seal=yes
EOF

systemctl restart systemd-journald
journalctl --flush
ls -ld /var/log/journal/$(cat /etc/machine-id)
journalctl --disk-usage
journalctl --verify | tail -5
systemctl reboot
