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

echo "-------------------------- TAMBAH MASA AKTIF AKUN SSH --------------------------"

if [[ $vps = "zvur" ]]; then
	echo ""
	echo ""
else
	echo "                         JOIN GRUP SSH & VPS DSVP.Net                         "
	echo "                https://www.facebook.com/groups/119545641875903/                " 
fi

	echo "           BY MOCH DAWN (https://web.facebook.com/profile.php?id=100013679919271)           "
echo ""

# begin of user-list
echo "-----------------------------------"
echo "USERNAME              EXP DATE     "
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------"
echo ""
# end of user-list

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	#read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF
	
	expiredate=$(chage -l $username | grep "Account expires" | awk -F": " '{print $2}')
	today=$(date -d "$expiredate" +"%Y-%m-%d")
	expire=$(date -d "$today + $AKTIF days" +"%Y-%m-%d")
	chage -E "$expire" $username
	passwd -u $username
	#useradd -M -N -s /bin/false -e $expire $username

	echo ""
	echo "-----------------------------------"
	echo "Informasi SSH"
	echo "-----------------------------------"
	echo "Host/IP: $MYIP"
	echo "Dropbear Port: 443, 110, 109"
	echo "OpenSSH Port: 22, 143"
	echo "Squid Proxy: 80, 8080, 3128"
	echo "Username: $username"
	#echo "Password: $password"
	echo "Valid s/d: $(date -d "$today + $AKTIF days" +"%d-%m-%Y")"
	echo "-----------------------------------"
else
	echo "Username [$username] belum terdaftar!"
	exit 1
fi

cd ~/
rm -f /root/IP
