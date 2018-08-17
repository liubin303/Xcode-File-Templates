#! /bin/bash
echo "start setup  FileTemplates"

folderName="TakeAway"
templatesPath=~/Library/Developer/Xcode/Templates/File\ Templates/"${folderName}"

if [ -d "${templatesPath}" ]; then
    sudo rm -r "${templatesPath}"
fi

sudo mkdir -p "${templatesPath}"

SRC_HOME=`pwd`
sudo ln -s $SRC_HOME "${templatesPath}"


echo "finish setup FileTemplates in ${templatesPath}"



