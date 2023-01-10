#!/bin/bash

read -p "Please enter you comit message   " var_commit
echo " "

#git add .
#echo "*"
#sleep 1
git commit -m "$var_commit"
echo "*  *"
#sleep 1
#git push -u origin main
echo "*  *  *"
sleep 1
echo "Script Complete"

#