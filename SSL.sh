#!/bin/bash
clear
echo -e ""
echo -e "  🔒\033[1;36mCRIE UM CERTIFICADO SSL PARA SEU DOMINIO\033[1;37m"
echo -e ""
fun_bar () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

inst_pct () {
_pacotes=("nginx" "certbot" "python3-certbot-nginx" "vim" "ufw")
for _prog in ${_pacotes[@]}; do
apt install $_prog -y
done
}
fun_bar 'inst_pct'
fun_bar 'copyfile'

copyfile (){
ufw allow https
cd /etc/nginx/sites-enabled && wget https://raw.githubusercontent.com/NT-GIT-HUB/SSL_CERTIFICATE/main/CONFIG
sleep 1
cd /etc/nginx/
rm sites-enabled/default
certbot --nginx
crontab -r >/dev/null 2>&1
(
	crontab -l 2>/dev/null
	echo "0 12 * * * /usr/bin/certbot renew --quiet"
) | crontab -
}
clear
echo -e ""
read -p "  DOMINIO: " -e -i www.google.com dm
sed -i 's/www.google.com/'$dm'/g' /etc/nginx/sites-enabled/CONFIG
