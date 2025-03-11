
#!/bin/bash

# Directorio a comprimir
SOURCE_DIR="/var/www"

# Nombre del archivo tar de salida
OUTPUT_FILE="websites_backup_20250307.tar.gz"

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