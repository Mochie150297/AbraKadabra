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

JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

echo "-----------------------------------"
echo "Jumlah akun: $JUMLAH user"
echo "-----------------------------------"
echo ""
echo "----------------------------------------------------------------"

if [[ $vps = "zvur" ]]; then
	echo ""
	echo ""
else
	echo " JOIN GRUP SSH & VPS DSVP.Net"
	echo " https://www.facebook.com/groups/119545641875903/"
fi
	
	echo " BY MOCH DAWN (https://web.facebook.com/profile.php?id=100013679919271)"
echo "----------------------------------------------------------------"
echo ""

cd ~/
rm -f /root/IP
