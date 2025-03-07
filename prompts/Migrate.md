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