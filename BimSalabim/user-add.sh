#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

#vps="zvur";
vps="aneka";

if [[ $vps = "zvur" ]]; then
	source="http://scripts.gapaiasa.com"
else
	source="https://raw.githubusercontent.com/Mochie150297/AbraKadabra/master/BimSalabim"
fi

# go to root
cd

# check registered ip
wget -q -O IP $source/IP.txt
if ! grep -w -q $MYIP IP; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "zvur" ]]; then
		echo ""
	else
		echo "Hubungi : Moch Dawn (https://web.facebook.com/profile.php?id=100013679919271)"
	fi
	rm -f /root/IP
	exit
fi

echo "--------------------------- MEMBUAT AKUN SSH/OPENVPN ---------------------------"

if [[ $vps = "zvur" ]]; then
	echo ""
	echo ""
else
	echo "                         JOIN GRUP SSH & VPS DSVP.Net                         "
	echo "                https://www.facebook.com/groups/119545641875903/                " 
fi

	echo "           BY MOCH DAWN (https://web.facebook.com/profile.php?id=100013679919271)           "
echo ""

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "Username [$username] sudah ada!"
	exit 1
else
	read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF

	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd

	echo ""
	echo "-----------------------------------"
	echo "Informasi SSH"
	echo "-----------------------------------"
	echo "Host/IP: $MYIP"
	echo "Dropbear Port: 443, 110, 109, 80"
	echo "OpenSSH Port: 22, 143"
	echo "Squid Proxy: 8000, 8080, 3128"
	echo "Username: $username"
	echo "Password: $password"
	echo "Valid s/d: $(date -d "$AKTIF days" +"%d-%m-%Y")"
	echo "-----------------------------------"
fi

cd ~/
rm -f /root/IP
