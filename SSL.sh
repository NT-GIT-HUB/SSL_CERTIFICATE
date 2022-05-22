apt-get update -y; apt-get upgrade -y;
apt-get install nginx certbot python3-certbot-nginx vim ufw -y
ufw allow https
cd /etc/nginx/sites-enabled && wget https://raw.githubusercontent.com/NT-GIT-HUB/SSL_CERTIFICATE/main/CONFIG
read -p "DOMINIO: " -e -i www.google.com dm
sed -i 's/www.google.com/'$dm'/g' /etc/nginx/sites-enabled/CONFIG
sleep 1
cd /etc/nginx/
rm sites-enabled/default
clear
certbot --nginx
crontab -r >/dev/null 2>&1
(
	crontab -l 2>/dev/null
	echo "0 12 * * * /usr/bin/certbot renew --quiet"
) | crontab -