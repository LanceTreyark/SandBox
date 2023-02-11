#!/bin/bash
<<comment
Run with alias command "xscp"
comment
# Date: 2.11.23
# Purpose: make scp unpaking server side simpler
# nano xscp.sh
# sudo chmod +x xscp.sh
# alias xscp="sh ~/xscp.sh"


#ERROR sudo tar -xf /var/www/pck.treyark.com/public_html/scp3r0210230438PM.tar.gz 
# does nothing
echo "This script is designed to unpack files made by scp3r to the www directory"
sleep 2
cd /tmp
sleep 1
read -p "Press enter to continue" x
echo "-----------------------------------------------------------------"
echo "Your current path is:"
pwd
sleep 1
echo "-----------------------------------------------------------------"
echo "Here is what is in the /tmp directory:"
echo ""
ls -n -1
sleep 1
read -p "Press enter to continue" x
echo "-----------------------------------------------------------------"
read -p "Enter the filename you want to deliver to the final destination:   " fileToDeliver
echo "-----------------------------------------------------------------"
sleep 1
echo "Here is the www directory"
echo ""
ls -n -1 /var/www
echo "-----------------------------------------------------------------"
sleep 1
echo ""
read -p "Enter the directory path you would like to explore:   " explore
sudo ls -n -1 $explore
sleep 1
echo "-----------------------------------------------------------------"
read -p "Enter the directory path you would like to explore:   " explore
sudo ls -n -1 $explore
sleep 1
echo "-----------------------------------------------------------------"
read -p "Enter the directory path you would like to explore:   " explore
sudo ls -n -1 $explore
sleep 1
echo "-----------------------------------------------------------------"
echo "Enter the final path you would like deliver the tar file to,"
read -p "Be sure to have the path begin and end with '/':    " finalPath
sudo ls -n -1 $finalPath
sleep 1
echo "-----------------------------------------------------------------"
echo "Moving a copy of the file..."
sudo cp $fileToDeliver $finalPath
sudo ls -n -1 $finalPath 
echo "-----------------------------------------------------------------"
sleep 1
echo "Unwrapping the file..."
sudo tar -xf $finalPath$fileToDeliver
sudo ls -n -1 $finalPath
sleep 1
echo "-----------------------------------------------------------------"
echo "The script will now remove the tar file, to abort press ctrl+c"
read -p "Press enter to continue" x