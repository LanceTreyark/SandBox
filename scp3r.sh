#!/bin/bash
# Date: 2.9.23
# Purpose: make scp simpler
# nano scp3r.sh
# sudo chmod +x scp3r.sh
echo "Your current path is:"
pwd
echo ""
todaysDate=$(date +%m%d%y)
timeNow=$(date +%I%M%p)
zfilename="scp3r${todaysDate}${timeNow}.tar.gz"
echo "todaysDate $todaysDate"
echo ""
echo "timeNow $timeNow"
echo ""
echo "zFile name: $zfilename"
sleep 2
echo ""
echo "(OPTIONAL) Add the path to the file you want to export ie: /mnt/c/Users/treya/Desktop/ "
read -p "If nothing is entered the default will be your current path   " filePath
filePath=${filePath:-$(pwd)}
echo ""
echo "here is a list of your current directory:"
echo "-----------------------------------------------------------------------------"
ls -a -1
echo "-----------------------------------------------------------------------------"
read -p "enter the name of the file to be exported:   " fileName
echo ""
echo "(OPTIONAL) enter the export address ie:Casp3r@152.44.45.184"                                                                                                                                                                                                   
read -p "If nothing entered the default is Casp3r@152.44.45.184:   " exportAddr 
exportAddr=${exportAddr:-Casp3r@152.44.45.184}
echo ""
echo "here is the data you provided:"
echo "file to be exported is at the end of following path:"
echo "$filePath$fileName"
echo ""
echo "The export address will be: $exportAddr"
echo ""
sleep 1
echo "Export file name will be: $zfilename"
sleep 1
echo " "
echo "Nav to dir"
cd $filePath
echo "Compressing file $fileName into $zfilename"                                                                                                                                                                                                                    
echo ""
sleep 1
tar -zcvf $zfilename $fileName
sleep 2
echo "$zfilename"
echo ""
echo "Sending to remote server via scp"
scp $zfilename $exportAddr:/tmp/$zfilename
echo "$zfilename will now be removed"
read -p "Press enter to proceed, or ctrl+c abort" x
rm $zfilename
echo "The script has concluded"
echo "Bye"