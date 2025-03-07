## Antes de migrar

# Ver sistema operativo y +

cat /etc/os-release

# Revisar qué tecnologías tenemos para instalar en EC2 

systemctl list-units --type=service --state=running