# 🚀 TP Final Linux - Hélios Logistique

## 👨‍💻 Auteur

**Yacine KHIAT**

---

## 📋 Présentation

Ce projet consiste à déployer, sécuriser et superviser une plateforme de suivi des tournées pour l'entreprise fictive **Hélios Logistique**.

Les objectifs principaux étaient :

- Administration des utilisateurs et groupes
- Gestion des permissions et ACL
- Déploiement d'un service Systemd
- Sécurisation SSH
- Configuration du pare-feu
- Supervision avec Zabbix
- Automatisation des sauvegardes
- Validation des procédures de restauration

---

## ✅ E1 - Gestion des comptes

Création :

- Groupe `suivi`
- Utilisatrice `lea`
- Compte système `helios-suivi`

Configuration de la politique de mots de passe :

- PASS_MAX_DAYS = 90
- PASS_MIN_DAYS = 1
- PASS_WARN_AGE = 14
- INACTIVE = 7

---

## ✅ E2 - Permissions et ACL

Création de l'arborescence :

```bash
/srv/helios/suivi/www
```

Paramètres appliqués :

```bash
Propriétaire : root
Groupe : suivi
Permissions : 2770
```

Mise en place d'ACL afin de permettre :

- l'accès au service
- l'accès aux outils de supervision
- l'héritage automatique des droits

---

## ✅ E3 - Publication

Développement du script :

```bash
helios-suivi-publish.sh
```

Fonctionnalités :

- Lock anti-concurrence
- Journalisation
- Gestion des erreurs
- Gestion des signaux

---

## ✅ E4 - Service Systemd

Création du service :

```bash
helios-suivi.service
```

Caractéristiques :

- Exécution sous l'utilisateur `helios-suivi`
- Port HTTP : `8080`
- Isolation renforcée
- Limitation CPU et mémoire
- Durcissement Systemd

---

## ✅ E5 - Délégation sudo

Mise en place d'une délégation contrôlée permettant :

- consultation de l'état du service
- consultation des journaux
- redémarrage du service

L'arrêt du service reste volontairement interdit.

---

## ✅ E6 - Pare-feu

Ouverture du port :

```bash
8080/tcp
```

Validation réalisée via :

```bash
firewall-cmd
```

---

## ✅ E7 - Sécurisation SSH

Mesures appliquées :

- Changement du port SSH
- Désactivation du login root
- Restriction des utilisateurs autorisés
- Renforcement de la sécurité de connexion

---

## ✅ E8 - Supervision Zabbix

Installation :

```bash
zabbix-agent2
sysstat
```

Création des métriques personnalisées :

```bash
helios.suivi.http
helios.suivi.age
```

Validation via :

```bash
zabbix_get
```

---

## ✅ E9 - Sauvegarde et restauration

Développement du script :

```bash
helios-suivi-backup.sh
```

Fonctionnalités :

- Sauvegarde compressée
- Conservation des ACL
- Checksum SHA-256
- Rotation automatique des sauvegardes
- Restauration sélective

Les tests de restauration ont confirmé la conservation des permissions et des ACL.

---

## 📂 Scripts réalisés

```text
helios-collect.sh
helios-archive.sh
helios-suivi-publish.sh
helios-suivi-backup.sh
helios-watchauth.sh
helios-suivi.conf
```

---

## 🎯 Résultat

L'ensemble des objectifs du sujet a été réalisé avec succès :

✅ Gestion des utilisateurs

✅ Gestion des ACL

✅ Service Systemd sécurisé

✅ Sécurisation SSH

✅ Supervision Zabbix

✅ Sauvegarde et restauration

✅ Validation complète du projet

---

# Merci pour votre lecture 🙂
# Yacine KHIAT
