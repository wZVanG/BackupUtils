# En Google Cloud

## Primero, crea el directorio para los backups si no existe
mkdir -p /home/ubuntu/dbs

## Guarda este script como backups_all_dbs.sh
Crear el archivo backups_all_dbs.sh

## Haz el script ejecutable
chmod +x backups_all_dbs.sh

## Ejecuta el script
./backups_all_dbs.sh

## Comprime la carpeta dbs
tar -czvf mysql_backups.tar.gz /home/ubuntu/dbs/

## Copiar backup a EC2
scp -i "clave.pem" /home/ubuntu/mysql_backups.tar.gz ubuntu@ec2-[IP-CON-GUIONES].us-east-2.compute.amazonaws.com:/home/ubuntu/restores/

# En EC2

## Crear un directorio para los backups
mkdir -p mysql_backups

## Descomprimir
tar -xzvf mysql_backups.tar.gz -C mysql_backups/