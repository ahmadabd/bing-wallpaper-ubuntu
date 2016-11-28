#!/bin/bash

# This script is written by Ahmad Abdollahzade . use it , make it better and share it .

# Get download link and store it on downLink .
downLink=$(./index.py)

# Making pic name .
picName=$(echo $downLink | cut -f7 -d"/")

# Set picture options
# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,spanned
picOpts="zoom"

if [ $downLink != "net is off" ]
then
    mkdir -p $HOME/Pictures/BingDesktopImagePython/
    # Download the link by wget .
    wget -O $HOME/Pictures/BingDesktopImagePython/$picName "$downLink" &> /dev/null
    # Set the GNOME3 wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/BingDesktopImagePython/$picName"
    # Set the GNOME 3 wallpaper picture options
    gsettings set org.gnome.desktop.background picture-options $picOpts
else
    echo -e "Net is off :("
fi

# Exit the script
exit
