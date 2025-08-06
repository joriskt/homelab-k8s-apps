
# Bookstack

## Docker


### Exporteren

Database exporteren:

```bash
$ docker exec -it bookstack_db /bin/bash

# Binnen container
$ cd /tmp && mysqldump -u bookstack -p bookstack > dump.sql
^D

# Buiten container
$ docker cp bookstack_db:/tmp/dump.sql bookstack-db.sql
```

Assets exporteren:

```bash
$ docker exec -it bookstack_db /bin/bash

# Binnen container
$ cd /config
$ tar -czvhf bookstack-backup.tar.gz www/.env backups www/files www/images www/themes www/uploads
$ mv bookstack-backup.tar.gz /tmp/
^D

# Buiten container
$ docker cp bookstack:/tmp/bookstack-backup.tar.gz .
```

## Kubernetes


### DB restore

```bash
$ k port-forward svc/bookstack-db-svc 3306:3306 -n bookstack

# Kopieer het wachtwoord:
$ sops edit apps/bookstack/base/database/bookstack-db-secret.yaml

# Plak het wachtwoord:
$ mysql -h 127.0.0.1 -u bookstack -D bookstack  --password=__WACHTWOORD_HIER__ < ~/bookstack-db.sql

# Sluit SOPS en de port-forward. Je hebt de DB hersteld!
```

### Data restore

```bash

# Lokaal
$ mkdir bookstack-backup
$ tar -xf bookstack-backup.tar.gz -C bookstack-backup
$ cd bookstack-backup

# Vind de naam van de pod. Hij moet de PVC op /config gemount hebben!
$ export POD=bookstack-5698545c49-bk5bv

# Vervolgens:
$ k cp . bookstack/$POD:/config -n bookstack

# Nu gaan we checken of het gewerkt heeft.
# Open een terminal in de pod:
$ k exec -it -n bookstack pod/$POD -- /bin/sh

# Binnen de pod, gebruik autocomplete om te checken of deze map en submappen bestaan:
$ cd config/www/uploads/images/drawio

# Zo ja is de restore gelukt.
```

### URL aanpassen

Dit is nodig als je een prod backup naar staging hebt gekopieerd.

```bash

# Open een terminal in de pod:
$ k exec -it -n bookstack pod/$POD -- /bin/sh

# Update de URLs in de database:
$ php /app/www/artisan bookstack:update-url https://wiki.joris.me https://wiki.staging.joris.me/

```
