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

while :
do
	#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
	#if [ "$MYIP" = "" ]; then
		#MYIP=$(wget -qO- ipv4.icanhazip.com)
	#fi

	clear

	echo "--------------- Selamat datang di Server - IP: $MYIP ---------------"
	echo ""
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')

	echo -e "\e[032;1mCPU model:\e[0m $cname"
	echo -e "\e[032;1mNumber of cores:\e[0m $cores"
	echo -e "\e[032;1mCPU frequency:\e[0m $freq MHz"
	echo -e "\e[032;1mTotal amount of ram:\e[0m $tram MB"
	echo -e "\e[032;1mTotal amount of swap:\e[0m $swap MB"
	echo -e "\e[032;1mSystem uptime:\e[0m $up"
	echo -e "\e[034;1mModified By:\e[0m \e[031;1mMoch Dawn DSVP.Net\e[0m"
	echo -e "\e[034;1mFacebook   :\e[0m \e[031;1mhttps://web.facebook.com/profile.php?id=100013679919271\e[0m"
	echo -e "\e[034;1mMore Info  :\e[0m \e[031;1m087756981059\e[0m"
	echo "------------------------------------------------------------------------------"
	echo "Apa yang ingin Anda lakukan?"
	echo -e "\e[031;1m 1\e[0m) \e[032;1mBuat Akun SSH/OpenVPN\e[0m"
	echo -e "\e[031;1m 2\e[0m) \e[033;1mGenerate Akun SSH/OpenVPN\e[0m"
	echo -e "\e[031;1m 3\e[0m) \e[034;1mGanti Password Akun SSH/OpenVPN\e[0m"
	echo -e "\e[031;1m 4\e[0m) \e[035;1mTambah Masa Aktif Akun SSH/OpenVPN\e[0m"
	echo -e "\e[031;1m 5\e[0m) \e[036;1mHapus Akun SSH/OpenVPN\e[0m"
	echo -e "\e[031;1m 6\e[0m) \e[037;1mBuat Akun PPTP VPN\e[0m"
	echo -e "\e[031;1m 7\e[0m) Monitoring Dropbear"
	echo -e "\e[031;1m 8\e[0m) \e[032;1mCek Login Dropbear, OpenSSH, PPTP VPN dan OpenVPN\e[0m"
	echo -e "\e[031;1m 9\e[0m) \e[033;1mKill Multi Login Manual (1-2 Login)\e[0m"
	echo -e "\e[031;1m10\e[0m) \e[034;1mAutoKill Multi Login (2-3 Login)\e[0m"
	echo -e "\e[031;1m11\e[0m) \e[035;1mDaftar Akun dan Expire Date\e[0m"
	echo -e "\e[031;1m12\e[0m) \e[036;1mDaftar Akun Aktif\e[0m"
	echo -e "\e[031;1m13\e[0m) \e[037;1mDaftar Akun Expire\e[0m"
	echo -e "\e[031;1m14\e[0m) Disable Akun Expire"
	echo -e "\e[031;1m15\e[0m) \e[032;1mDelete Akun Expire\e[0m"
	echo -e "\e[031;1m16\e[0m) \e[033;1mBanned Akun\e[0m"
	echo -e "\e[031;1m17\e[0m) \e[034;1mUnbanned Akun\e[0m"
	echo -e "\e[031;1m18\e[0m) \e[035;1mRestart Dropbear\e[0m"
	echo -e "\e[031;1m19\e[0m) \e[036;1mMemory Usage\e[0m"
	echo -e "\e[031;1m20\e[0m) \e[037;1mSpeedtest\e[0m"
	echo -e "\e[031;1m21\e[0m) Benchmark"
	echo -e "\e[031;1m22\e[0m) \e[032;1mRestart Webmin\e[0m"
	echo -e "\e[031;1m23\e[0m) \e[033;1mEdit Banner SSH Login (Dropbear/OpenSSH)\e[0m"
	echo -e "\e[031;1m24\e[0m) \e[034;1mEdit Port\e[0m"
	echo -e "\e[031;1m25\e[0m) \e[035;1mGanti Password root\e[0m"
	echo -e "\e[031;1m26\e[0m) \e[036;1mUpdate Script\e[0m"
	echo -e "\e[031;1m27\e[0m) \e[037;1mReboot Server\e[0m"
	echo ""
	echo -e "\e[031;1m x\e[0m) Exit"
	echo ""
	read -p "Masukkan pilihan anda, kemudian tekan tombol ENTER: " option1
	case $option1 in
		1)
		clear
		user-add
		exit
		;;
		2)
		clear
		user-gen
		exit
		;;
		3)
		clear
		user-pass
		exit
		;;
		4)
		clear
		user-renew
		exit
		;;
		5)
		clear
		user-del
		exit
		;;
		6)
		clear
		user-add-pptp
		exit
		;;
		7)
		clear
		#read -p "Isikan Port Dropbear yang akan dimonitor: " PORT
		#dropmon $PORT
		dropmon
		exit
		;;
		8)
		clear
		user-login
		exit
		;;
		9)
		clear
		#read -p "Isikan Maximal Login (1-2): " MULTILOGIN
		#user-limit $MULTILOGIN
		user-limit
		exit
		;;
		10)
		clear
		autokill
		exit
		;;
		11)
		clear
		user-list
		exit
		;;
		12)
		clear
		user-active-list
		exit
		;;
		13)
		clear
		user-expire-list
		exit
		;;
		14)
		clear
		disable-user-expire
		exit
		;;
		15)
		clear
		delete-user-expire
		exit
		;;
		16)
		clear
		banned-user
		exit
		;;
		17)
		clear
		unbanned-user
		exit
		;;
		18)
		clear
		service dropbear restart
		exit
		;;
		19)
		clear
		ps-mem
		exit
		;;
		20)
		clear
		speedtest --share
		exit
		;;
		21)
		clear
		benchmark
		exit
		;;
		22)
		clear
		service webmin restart
		exit
		;;
		23)
		clear
		banner
		exit
		;;
		24)
		clear
		edit-port
		exit
		;;
		25)
		clear
		root-pass
		exit
		;;
		26)
		clear
		wget -O /usr/bin/update http://anekascript.anekavps.us/Debian7/update
		chmod +x /usr/bin/update
		update
		exit
		;;
		27)
		clear
		reboot
		exit
		;;
		x)
		clear
		exit
		;;
	esac
done

cd ~/
rm -f /root/IP
