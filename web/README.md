chmod +x bk-www.sh

./backup-www.sh

scp -i "clave.pem" /home/ubuntu/websites_backup.tar.gz ubuntu@ec2-[IP-GUIONES].us-east-2.compute.amazonaws.com:/home/ubuntu/restores/


## Después en cada repositorio git


git config user.name "Nombre"
git config user.email "mail@mail.com"

git fetch --all

## Opcional 1
git reset --soft HEAD@{0}
## Opcional 2 - Verifica que la URL remota siga correcta
git config --get remote.origin.url
