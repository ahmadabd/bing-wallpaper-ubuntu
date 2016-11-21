#!/usr/bin/env python
import re
import requests
import BeautifulSoup
import os

# bing wallpaper.
# auther : Ahmad Abdollahzade (ahmadabd13741112@gmail.com)

def getLink():
    if os.uname()[0] == "Linux":
        baseUrl = "http://www.bing.com"          
        imgUrl = "http://www.bing.com/HPImageArchive.aspx?format=xml&idx=1&n=1&mkt=en-US"
        try:
            html = requests.get(imgUrl)  # Get xml code .
        except:
            print "net is off"    # it runs if net is off .
        else:
            soup = BeautifulSoup.BeautifulSoup(html.content)     
            link = soup.find('url',text = re.compile('(.jpg)$'))    #Get first <url> ... </url> string .
            downLink = baseUrl + link   # make download link .
            print downLink     
    else:
        print "Your os should be Linux."
        exit()
getLink()

