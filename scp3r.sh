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
sudo tar -zcvf $zfilename $fileName
sleep 2
echo "$zfilename"
echo ""
echo "Sending to remote server via scp"
scp $zfilename $exportAddr:/tmp/$zfilename
echo "Now that the file has been exported the script will automatically remove that $zfilename file"
read -p "Press enter to proceed or ctrl+c to keep the file and abort the delete" x
rm $zfilename

<<comment
read -p "Delete the $zfilename file? (Y/N): " answer
if [[ $answer =~ ^[Yy]$ ]]; then
  rm -f "$zfilename"
  echo "$zfilename has been deleted."
else
  echo "$zfilename has not been deleted."
fi
#

#
read -p "Delete the $zfilename file? (Y/N): " user_input
if [[ "$user_input" =~ ^[Yy]$ ]]; then
  rm "$zfilename"
  if [ $? -eq 0 ]; then
    echo "$zfilename has been deleted."
  else
    echo "$zfilename has not been deleted."
  fi
else
  echo "$zfilename has not been deleted."
fi
#

read -p "Delete the scp3r0210230601AM.tar.gz file? (Y/N): " choice
# check if the answer is "y" or "Y"
if [ "${choice,,}" == "y" ]; then
  rm scp3r0210230601AM.tar.gz
  echo "scp3r0210230601AM.tar.gz has been deleted."
else
  echo "scp3r0210230601AM.tar.gz has not been deleted."
fi
This should resolve the error and allow you to accept both "y" and "Y".
comment
#
<<comment
read -p "Delete the scp3r0210230557AM.tar.gz file? (Y/N): " user_input
if [[ "$user_input" =~ ^(yes|y|YES|Y)$ ]]; then
  rm scp3r0210230557AM.tar.gz
  echo "scp3r0210230557AM.tar.gz has been deleted."
else
  echo "scp3r0210230557AM.tar.gz has not been deleted."
fi
comment
#
<<comment
read -p "Delete the $zfilename file? (Y/N): " answer
# Check if the answer is "y" or "Y"
if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
  # Delete the file if the answer is "y" or "Y"
  rm scp3r0210230547AM.tar.gz

  # Check if the file has been deleted
  if [ ! -f scp3r0210230547AM.tar.gz ]; then
    echo "scp3r0210230547AM.tar.gz has been deleted."
  else
    echo "scp3r0210230547AM.tar.gz has not been deleted."
  fi
else
  echo "scp3r0210230547AM.tar.gz has not been deleted."
fi
comment
#
<<comment
read -p "Delete the $zfilename file? (Y/N): " answer
if [ "$answer" == "y" ]; then
  rm $zfilename
  echo "$zfilename has been deleted."
else
  echo "$zfilename has not been deleted."
fi
comment