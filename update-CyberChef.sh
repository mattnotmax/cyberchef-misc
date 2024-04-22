#!/bin/bash 
INSTALL_LOC="/home/$(whoami)/bin/CyberChef"
INSTALL_LOC_FOLDER="$INSTALL_LOC/current"
echo "[+] Checking for previous installation directory"
if [[ ! -d $INSTALL_LOC ]]
then
	echo "[+] Directory not found, creating."
	mkdir -p $INSTALL_LOC
fi

RELEASE=$(curl -s https://api.github.com/repos/gchq/CyberChef/releases/latest | grep tag_name | cut -d '"' -f 4)

if [[ -f $INSTALL_LOC/version.txt ]]
then
	if [[ $(cat $INSTALL_LOC/version.txt) == $RELEASE ]]
	then
		echo "[+] CyberChef is up-to-date at $RELEASE"
		exit 0
	fi
fi
echo "[+] New version $RELEASE located"
find $INSTALL_LOC -type f -not -name version.txt -not -name update-CyberChef.sh -delete
ZIP=https://github.com/gchq/CyberChef/releases/download/$RELEASE/CyberChef_$RELEASE.zip
echo "[+] Downloading CyberChef_$RELEASE.zip from Github"
curl -Ls $ZIP --output $INSTALL_LOC/CyberChef_$RELEASE.zip
echo "[+] Extracting ZIP to $INSTALL_LOC"
unzip -q $INSTALL_LOC/CyberChef_$RELEASE.zip -d $INSTALL_LOC_FOLDER
mv $INSTALL_LOC_FOLDER/CyberChef_$RELEASE.html $INSTALL_LOC_FOLDER/CyberChef.html
echo "[+] Cleaning up..."
rm $INSTALL_LOC/CyberChef_$RELEASE.zip
mv /home/$(whoami)/bin/CyberChef/CyberChef_* /home/$(whoami)/bin/CyberChef/CyberChef.html
echo $RELEASE > $INSTALL_LOC/version.txt
echo "[+] Complete."
