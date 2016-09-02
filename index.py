import re
import requests
import BeautifulSoup

def getLink():
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

getLink()

