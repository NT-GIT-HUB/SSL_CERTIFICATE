apt-get update -y; apt-get upgrade -y;
apt-get install nginx certbot python3-certbot-nginx vim ufw -y
ufw allow https
mkdir $HOME/SSL
cd $HOME/SSL && wget https://raw.githubusercontent.com/NT-GIT-HUB/SSL_CERTIFICATE/main/CONFIG
read -p "DOMINIO: " -e -i www.google.com dm
sed 's/www.google.com/'$dm'/g' $HOME/SSL/CONFIG
sleep 1
chmod +x $(ls)
mv $HOME/SSL/CONFIG /etc/nginx/sites-enabled
rmdir $HOME/SSL
cd /etc/nginx/
rm sites-enabled/default
clear
certbot --nginx
crontab -r >/dev/null 2>&1
(
	crontab -l 2>/dev/null
	echo "0 12 * * * /usr/bin/certbot renew --quiet"
) | crontab -