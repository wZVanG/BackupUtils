Eres un profesional en DevOps y vas a hacer una migración desde una máquina de Google Compute Engine a Amazon EC2.

Características de la máquina Google Compute Engine:

NAME="Ubuntu"
VERSION="18.04.6 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.6 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bioni

Características de la máquina EC2:

NAME="Ubuntu"
VERSION="18.04.6 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.6 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic

Arquitectura: x86_64

Servicios específicos que están en Google Compute Engine y deben instalarse en EC2:

- apache2.service:
Server version: Apache/2.4.29 (Ubuntu)

- mariadb.service:
mysql  Ver 15.1 Distrib 10.4.28-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2

- nginx.service:
nginx version: nginx/1.14.0 (Ubuntu)

- php7.2-fpm.service:
PHP 7.2.24-0ubuntu0.18.04.17 (fpm-fcgi) (built: Feb 23 2023 13:29:25)

Paquetes instalados:

- NodeJS v12.22.12
- pm2 5.2.0

Mi script para generar backups de la carpeta es /var/www:


#!/bin/bash

# Directorio a comprimir
SOURCE_DIR="/var/www"

# Nombre del archivo tar de salida
OUTPUT_FILE="websites_backup.tar.gz"

# Crear el archivo comprimido excluyendo archivos innecesarios
tar --exclude="*/.git/objects/*" \
    --exclude="*/.git/hooks/*" \
    --exclude="*/.git/logs/*" \
    --exclude="*/.git/packed-refs" \
    --exclude="*/.git/index" \
    --exclude="*/node_modules/*" \
    --exclude="*/vendor/*" \
    --exclude="*/__pycache__/*" \
    --exclude="*/.DS_Store" \
    --exclude="*/cache/*" \
    --exclude="*/tmp/*" \
    -czf $OUTPUT_FILE $SOURCE_DIR

echo "Backup creado en $OUTPUT_FILE"


Mi script para generar backups de la base de datos es:

#!/bin/bash

# Pide la contraseña una sola vez
echo -n "Ingresa la contraseña de MySQL: "
read -s MYSQL_PWD
export MYSQL_PWD
echo

# Obtiene la lista de bases de datos (excepto las del sistema)
databases=$(mysql -u root -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)")

# Exporta cada base de datos
for db in $databases; do
  echo "Backing up database: $db"
  # Realizar el dump sin la opción --skip-definer
  mysqldump -u root \
    --routines \
    --triggers \
    --events \
    --single-transaction \
    --quick \
    --hex-blob \
    --add-drop-table \
    --create-options \
    --extended-insert \
    --set-charset \
    "$db" > "/home/ubuntu/dbs/$db.sql.tmp"
    
  # Usar sed para modificar los definidores en el archivo resultante
  sed -r 's/DEFINER=`[^`]+`@`[^`]+`//g' "/home/ubuntu/dbs/$db.sql.tmp" > "/home/ubuntu/dbs/$db.sql"
  
  # Eliminar el archivo temporal
  rm "/home/ubuntu/dbs/$db.sql.tmp"
done

# Limpia la variable de contraseña
unset MYSQL_PWD

echo "Backup completado. Los archivos están en /home/ubuntu/dbs/"

Otros detalles a configurar:

Definir en la máquina el timezone a "America/Bogota"

Ahora dime paso a paso como hacer la migración si ya tengo la máquina de EC2 lista y ya puedo acceder a la consola. Trata de recomendarme colocar los requerimientos que se hacen antes en la nueva máquina, y más lo que debo hacer e instalar. Esto con el fin de tener los mismos proyectos que tuve en mi antiguo servidor. En las tecnologías trata de que se puedan instalar las mismas versiones.

