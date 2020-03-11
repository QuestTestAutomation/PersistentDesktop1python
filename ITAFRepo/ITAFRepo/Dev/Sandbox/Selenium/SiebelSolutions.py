from selenium import webdriver
from Dev.Utilities import Utillib
from Dev.Utilities import InitializeITAF
from Dev.Utilities import Seleniumutil
from Dev.Siebel import Souilib
from Dev.Excel import XLLib
from Dev.Utilities import Seleniumutil
from Dev.Marketing.Libs.PageObjectLibrary import *
#from Dev.Marketing.Libs import MarketingLib
from Dev.TestRails import ITAFTestRailLibrary
from Dev.Siebel import Siebelservicelib
import time

Variablesfile  = 'C:/Users/sanumolu/Documents/QSTAFGdrive/VDI 1/ITAF/ITAFRepo/Dev/Resources/ITAFParameters.cfg'
runmanagerfile = 'C:/Users/sanumolu/Documents/QSTAFGdrive/VDI 1/ITAF/ITAFRepo/Dev/Files/Siebel Service/ITAF_RunManager_Service_MS_Patch temp.xlsx'
runmanagersheet = 'RunManager'
databankfile = 'C:/Users/sanumolu/Documents/QSTAFGdrive/VDI 1/ITAF/ITAFRepo/Dev/Files/Siebel Service/ITAF_DataBank_Service_MSPatch.xlsx'
trresultdict = {}

iniittaf = InitializeITAF.initializeITAF()
globaldict = iniittaf.set_global_dictionary(Variablesfile)
print('globaldict')

utillib = Utillib.utillib()
brow = "gc"
url  = "http://siebeluat/sales_enu/start.swe?SWECmd=AutoOn"
url = 'http://siebeluat.prod.quest.corp/dbsupport_enu/start.swe?SWECmd=AutoOn'

driver = utillib.Get_Driver_Handle(utillib,brow)
driver.get(url)
print("hello world!")

start = url.index("_enu")
end = start + 4
print('****' + str(start))
print('****' + str(end))
print('99999' + url[0:end])
time.sleep(30)
lists = driver.find_elements_by_id('s_swepi_1')
print(len(lists))
driver.find_element_by_id('s_swepi_1').click()
time.sleep(5)
driver.find_element_by_id('s_swepi_1').send_keys(Keys.HOME)
driver.find_element_by_id('s_swepi_1').send_keys('SUPPORT_ADMIN')
driver.find_element_by_id('s_swepi_2').click()
time.sleep(5)
driver.find_element_by_id('s_swepi_2').send_keys('SUPPORT_ADMIN')

time.sleep(5)
#driver.find_element_by_xpath('//*[@id="s_swepi_22"]').click()
driver.find_element_by_link_text('Login').click()
