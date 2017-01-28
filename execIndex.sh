#!/bin/bash

# bing wallpaper.
# This script is written by Ahmad Abdollahzade . use it , make it better and share it .
# auther : Ahmad Abdollahzade (ahmadabd13741112@gmail.com)

# export DBUS_SESSION_BUS_ADDRESS environment variable useful when the script is set as a cron job
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-) 

# Get download link and store it on downLink variable.
function foundDownLink()
{
python - << CODE
import re
import requests
import BeautifulSoup
import os

def getLink():
    if os.uname()[0] == "Linux":
        baseUrl = "http://www.bing.com"          
        imgUrl = "http://www.bing.com/HPImageArchive.aspx?format=xml&idx=1&n=1&mkt=en-US"
        try:
            html = requests.get(imgUrl)  # Get xml code .
        except:
            print ("net is off")    # it runs if net is off .
        else:
            soup = BeautifulSoup.BeautifulSoup(html.content)     
            link = soup.find('url',text = re.compile('(.jpg)$'))    #Get first <url> ... </url> string .
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
