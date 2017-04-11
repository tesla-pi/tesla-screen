#!/usr/bin/python3
#Script is made to get all dishes and related info from Lindholmens dagliga meny.
import requests
from bs4 import BeautifulSoup
import lxml

weburl = "http://www.lindholmen.se/pa-omradet/dagens-lunch"

htmls = requests.get(weburl)
htmltext = htmls.text

uncommented = htmltext.replace("<!-- ", "")
uncommented = uncommented.replace("</span> -->", "</span>")
uncommented = uncommented.replace("\r\n", "")
soup = BeautifulSoup(uncommented, 'lxml')

menu = soup.find('div', class_="view-content")
dishes = menu.find_all('div', class_="node-content")

restaurant_name = "table-list__restaurant-label"
item_name = ("dish-name")
price_name = "table-list__column--price"
type_name = "icon-dish"



#Dishes contain all info needed now, what's left is to sort it and insert all info correctly into a table for display
for dish in dishes:
	print(dish.find('span', class_=restaurant_name).text)
	print(dish.find('span', class_=item_name).text.rstrip('\n'))
	print(dish.find('div', class_=price_name).text)
	print(dish.find('div', class_=type_name).text)
