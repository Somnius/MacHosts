#!/bin/bash

#variables
FETCH="curl" #wget or curl
FOUT="-o" #-O for wget -o for curl
HFOLDER="hosts"
MACHOSTSFILE="MacHosts.txt"

#clearing shell buffer
clear

#cleaning
rm -rf temp/ $HFOLDER

#working folder prep
mkdir hosts

#fetching adshosts
$FETCH "http://hosts-file.net/ad_servers.asp"
mv ad_servers.asp $HFOLDERadshosts.txt

#fetching bhosts
mkdir temp
cd temp
$FETCH "http://hosts-file.net/download/hosts.zip"
unzip -q hosts.zip
rm -rf *.zip
mv hosts.txt ../bhosts.txt
cd ..
rm -rf temp
mv bhosts.txt $HFOLDER

#fetching hphosts
$FETCH "http://hosts-file.net/hphosts-partial.asp"
mv hphosts-partial.asp $HFOLDERhphosts.txt

#fetching malhosts
$FETCH "http://www.malwaredomainlist.com/hostslist/hosts.txt" $FOUT $HFOLDER/malhosts.txt

#fetching mvps
mkdir temp
cd temp
$FETCH "http://winhelp2002.mvps.org/hosts.zip"
unzip -q hosts.zip
rm -rf *.zip
mv HOSTS ../mvps.txt
cd ..
rm -rf temp
mv mvps.txt $HFOLDER

#fetching sysctlhosts
$FETCH "http://sysctl.org/cameleon/hosts.win" $FOUT $HFOLDERsysctlhosts.txt

#fetching yoyohosts
$FETCH "http://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext" $FOUT $HFOLDERyoyohosts.txt

#merging files
cat $HFOLDER*.txt > all-hosts.txt

#cleaning 2
sed '/^#/ d' < all-hosts.txt > $MACHOSTSFILE
rm -rf all-hosts.txt $HFOLDER

#echo'ing
echo " "
echo "All fetched, check $MACHOSTSFILE"
echo " "