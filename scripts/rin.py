#you need to have python, chromium or chrome and selenium package installed 

import sys
import time
from selenium import webdriver 
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options

##########################################################################################################################
#this should point to a chromedriver that you can get here https://sites.google.com/a/chromium.org/chromedriver/downloads#
##########################################################################################################################

PATH = "/path/to/chromedriver"
auto = webdriver.ChromeOptions()
auto.add_experimental_option("excludeSwitches", ['enable-automation'])
auto.add_experimental_option('useAutomationExtension', False)

#set this to False to see what is happening in the browser for example for debugging purposes

auto.headless = True
auto.add_argument("--start-maximized")
driver = webdriver.Chrome(options=auto,
                    executable_path=PATH)
driver.get("https://cs.rin.ru/forum")
#maybe you dont need the sleep commands at all but who knows
time.sleep(3)
login = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/div[1]/div[2]/table[2]/tbody/tr/td[2]/a[2]")
login.click()
time.sleep(2)
username = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/div[2]/form/table/tbody/tr[2]/td[2]/table/tbody/tr[1]/td[2]/input")

#################################
#add your userename and password#
#################################

username.send_keys("your username")
#here                    ^^^
password = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/div[2]/form/table/tbody/tr[2]/td[2]/table/tbody/tr[2]/td[2]/input")
password.send_keys("your password")
#and here                ^^^
password.send_keys(Keys.RETURN)
time.sleep(5)
search = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/div[2]/table[1]/tbody/tr/td/div/form/input[1]")
search.send_keys(Keys.CONTROL + "a")
search.send_keys(sys.argv[1])
time.sleep(2)
search.send_keys(Keys.RETURN)
time.sleep(2)
print(driver.page_source)
driver.quit()
