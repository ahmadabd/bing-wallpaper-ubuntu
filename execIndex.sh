#!/bin/bash

# bing wallpaper.
# This script is written by Ahmad Abdollahzade . use it , make it better and share it .
# auther : Ahmad Abdollahzade (ahmadabd13741112@gmail.com)

# export DBUS_SESSION_BUS_ADDRESS environment variable useful when the script is set as a cron job
#PID=$(pgrep gnome-session)
#export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-) 

# Get download link and store it on downLink variable.
function foundDownLink()
{
python - << CODE
import requests
import os
import json

def getLink():
    if os.uname()[0] == "Linux":
        baseUrl = "http://www.bing.com"          
        api = "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"
        try:
            codes = requests.get(api)  # Get xml code .
	    jsonResult = json.loads(codes.content)
	    link = jsonResult["images"][0]["url"]
        except:
            print ("net is off")    # it runs if net is off .
        else:
            downLink = baseUrl + link   # make download link .
            print (downLink)     
    else:
        print ("Your os should be Linux.")
        exit()
getLink()
CODE
}

downLink=$(foundDownLink)

# Making pic name .
picName=$(echo $downLink | cut -f7 -d"/")

# Set picture options
# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,spanned

if [ $downLink != "net is off" ]
then
    DIR="$HOME/Pictures/BingDesktopImagePython"	
    FILE="$DIR/$picName"
    mkdir -p $DIR
    # Download the link by wget .
    wget -O $FILE "$downLink" &> /dev/null

    URI="file:///$FILE"
    # Set the GNOME 3 wallpaper picture options
    gsettings set org.gnome.desktop.background picture-options "zoom"
    # Set the GNOME3 wallpaper
    gsettings set org.gnome.desktop.background picture-uri $URI
else
    echo -e "Net is off :("
fi

# Exit the script
exit
