#!/bin/bash

#variables
WG="wget"

#clearing shell buffer
clear

#cleaning
rm -rf temp/ hosts/

#working folder prep
mkdir hosts

#fetching adshosts
$WG "http://hosts-file.net/ad_servers.asp"
mv ad_servers.asp hosts/adshosts.txt

#fetching bhosts
mkdir temp
cd temp
$WG "http://hosts-file.net/download/hosts.zip"
unzip -q hosts.zip
rm -rf *.zip
mv hosts.txt ../bhosts.txt
cd ..
rm -rf temp
mv bhosts.txt hosts/

#fetching hphosts
$WG "http://hosts-file.net/hphosts-partial.asp"
mv hphosts-partial.asp hosts/hphosts.txt

#fetching malhosts
$WG "http://www.malwaredomainlist.com/hostslist/hosts.txt" -O hosts/malhosts.txt

#fetching mvps
mkdir temp
cd temp
$WG "http://winhelp2002.mvps.org/hosts.zip"
unzip -q hosts.zip
rm -rf *.zip
mv HOSTS ../mvps.txt
cd ..
rm -rf temp
mv mvps.txt hosts/

#fetching sysctlhosts
$WG "http://sysctl.org/cameleon/hosts.win" -O hosts/sysctlhosts.txt

#fetching yoyohosts
$WG "http://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext" -O hosts/yoyohosts.txt

#merging files
cat hosts/*.txt > all-hosts.txt

#cleaning 2
sed '/^#/ d' < all-hosts.txt > MacHosts.txt
rm -rf all-hosts.txt hosts/

#echo'ing
echo " "
echo "All fetched, check MacHosts.txt"
echo " "