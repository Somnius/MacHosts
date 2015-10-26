#!/bin/bash

#variables
FETCH="curl -s" #wget or curl (wget -q or curl -s for quite)
FOUT="o" #O for wget o for curl
MACHOSTSFILE="MacHosts.txt"

#clearing shell buffer
clear

#echo'ing stuff
echo "MacHosts preV1.4"
echo "created by @SomniusX"
echo " "

#cleaning
echo "cleaning.."
rm -rf temp/ hosts
rm -rf $MACHOSTSFILE

#working folder prep
echo "preparing folders.."
mkdir hosts

#fetching adshosts
echo "fetching adshosts.."
$FETCH http://hosts-file.net/.%5Cad_servers.txt -$FOUT hosts/adshosts.txt
du -sh hosts/adshosts.txt | sed -e 's|hosts/||'

#fetching bhosts
echo "fetching bhosts.."
mkdir temp
cd temp
$FETCH "http://hosts-file.net/download/hosts.zip" -$FOUT hosts.zip
unzip -q hosts.zip
rm -rf *.zip
mv hosts.txt ../bhosts.txt
cd ..
rm -rf temp
mv bhosts.txt hosts/
du -sh hosts/bhosts.txt | sed -e 's|hosts/||'

#fetching hphosts
echo "fetching hphosts.."
$FETCH "http://hosts-file.net/hphosts-partial.asp" -$FOUT hphosts-partial.asp
mv hphosts-partial.asp hosts/hphosts.txt
du -sh hosts/hphosts.txt | sed -e 's|hosts/||'

#fetching malhosts
echo "fetching malhosts.. (takes its time!)"
$FETCH "http://www.malwaredomainlist.com/hostslist/hosts.txt" -$FOUT hosts/malhosts.txt
du -sh hosts/malhosts.txt | sed -e 's|hosts/||'

#fetching mvps
echo "fetching mvps.."
mkdir temp
cd temp
$FETCH "http://winhelp2002.mvps.org/hosts.zip" -$FOUT hosts.zip
unzip -q hosts.zip
rm -rf *.zip
mv HOSTS ../mvps.txt
cd ..
rm -rf temp
mv mvps.txt hosts/
du -sh hosts/mvps.txt | sed -e 's|hosts/||'

#fetching sysctlhosts
echo "fetching sysctlhosts.."
$FETCH "http://sysctl.org/cameleon/hosts.win" -$FOUT hosts/sysctlhosts.txt
du -sh hosts/sysctlhosts.txt | sed -e 's|hosts/||'

#fetching yoyohosts
echo "fetching yoyohosts.."
$FETCH "http://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext" -$FOUT hosts/yoyohosts.txt
du -sh hosts/yoyohosts.txt | sed -e 's|hosts/||'

#merging files
echo "mergning all fetched hosts.."
cat hosts/*.txt > all-hosts.txt | sed -e 's|hosts/||'

#cleaning 2
echo "cleaning.."
sed '/^#/ d' < all-hosts.txt > $MACHOSTSFILE
rm -rf all-hosts.txt hosts/

#echo'ing
echo " "
echo "All fetched, check $MACHOSTSFILE"
du -sh $MACHOSTSFILE
echo " "