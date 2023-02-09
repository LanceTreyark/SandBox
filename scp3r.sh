#!/bin/bash
# Date: 2.9.23
# Purpose: make scp simpler
# nano scp3r.sh
# sudo chmod +x scp3r.sh
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
zfilename="scp3r${todaysDate}${timeNow}.tar.gz"
echo "todaysDate $todaysDate"
echo "timeNow $timeNow"
echo "zFile name: $zfilename"
sleep 2
echo "Add the path to the file you want to export"
read -p "ie: /mnt/c/Users/treya/Desktop/ :   " filePath
read -p "enter the name of the file to be exported:   " fileName
read -p "enter the export address ie:Casp3r@152.44.45.184 :   " exportAddr 
echo "here is the data you provided:"
echo "file to be exported is at the end of following path:"
echo "$filePath"
echo ""
echo "The export address will be: $exportAddr"
sleep 1
echo "If this is correct press Enter to continue, or ctr+c to abort"
read -s -p ""
echo "Export file name will be: $zfilename"
sleep 1
echo "If this is correct press Enter to continue, or ctr+c to abort"
read -s -p ""
echo " "
echo "Nav to dir"
cd $filePath
ls -a -1
echo "Compressing file..."
sudo tar -zcvf $zfilename $fileName
sleep 2
ls -a -1
echo "Sending to remote server via scp"
echo "press Enter to continue, or ctr+c to abort"
read -s -p ""
scp $zfilename $exportAddr:/tmp/$zfilename