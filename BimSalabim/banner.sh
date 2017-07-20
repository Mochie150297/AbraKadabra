#!/bin/bash

read -d "~" -p "Silahkan Paste Banner anda disini (\"~\" jika sudah selesai):
" line

cat > /etc/issue.net <<-END
$line

################################################################################
##                                                                            ##
##                            MODIFIED BY MOCH DAWN                           ##
##           https://web.facebook.com/profile.php?id=100013679919271          ##
##                                                                            ##
################################################################################
##################  CLOSE BANNER INI AGAR ANDA BISA BROWSING  ##################
END

service dropbear restart
service ssh restart
