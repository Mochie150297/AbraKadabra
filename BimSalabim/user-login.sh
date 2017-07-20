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

data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "-----------------------------------"
echo "Checking Dropbear login";
echo "-----------------------------------"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	username=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $username - $IP";
	fi
done

echo "";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
echo "-----------------------------------"
echo "Checking OpenSSH login";
echo "-----------------------------------"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
	username=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
	IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $username - $IP";
	fi
done

echo "";

echo "-----------------------------------"
echo "Checking OpenVPN login";
echo "-----------------------------------"
tail -f /etc/openvpn/server-vpn.log

echo "";

echo "-----------------------------------"
echo "Checking PPTP login";
echo "-----------------------------------"
last | grep ppp | grep still

echo "";

#Melihat Riwayat Login User
echo "-----------------------------------"
echo "Checking PPTP Login History";
echo "-----------------------------------"
last | grep ppp

echo "";
echo "----------------------------------------------------------------"
echo " Kalau ada Multi Login Kill Aja "
echo " Tetap Multi Login Ganti Passnya baru Kill Lagi "
echo " Caranya pake Kill nomor PID "
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
