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
