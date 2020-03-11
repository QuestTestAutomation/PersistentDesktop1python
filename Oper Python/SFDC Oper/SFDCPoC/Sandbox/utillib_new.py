import time
import os
from SFDCPoC.Sandbox.XLLibP3 import *
import logging
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.support.ui import Select
from robot.libraries.BuiltIn import BuiltIn
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

class CPQLib() :

# def get_webdriver_instance():
#     se2lib = BuiltIn().get_library_instance('Selenium2Library')
#     return se2lib._current_browser()

    def __init__(self, driver):
        self.driver = driver

    def Hello_World(self):
        print("Hello World")

    def Open_Browser_And_Launch_Application(self,brow,url):
        if brow ==  'ff':
            driver = webdriver.Firefox()
         #   driver.get(url)
        if brow ==  'gc':
            driver = webdriver.Chrome(executable_path='C:\Drivers\chromedriver.exe')
            #driver = webdriver.Chrome()
            # driver.get(url)
            # driver = webdriver.Remote(command_executor='http://localhost:9515/',desired_capabilities=DesiredCapabilities.CHROME)
            # driver.get(url)
        if brow == 'ie':
            driver = webdriver.Ie()
        return driver


    def get_webdriver_instance(self):
        se2lib = BuiltIn().get_library_instance('Selenium2Library')
        return se2lib._current_browser()


    def increment_step_number(self,step):
        step = int(step) + int(1)

        return step

    def generate_phonenum(self) :
        phnum = time.strftime("%d%m%Y%H%M%S")

        return phnum

    def get_current_date(self):
        print (time.strftime("%H:%M:%S"))

        ## 12 hour format ##
        print (time.strftime("%I:%M:%S"))

        ## dd/mm/yyyy format
        print (time.strftime("%d/%m/%Y"))

        ## dd_mm_yyyy format
        print (time.strftime("%d_%m_%Y"))

        dttime = time.strftime("%d_%m_%Y")

        return dttime

    def get_current_date_time(self):
        print (time.strftime("%H:%M:%S"))

        ## 12 hour format ##
        print (time.strftime("%I:%M:%S"))

        ## dd/mm/yyyy format
        print (time.strftime("%d/%m/%Y"))

        ## dd_mm_yyyy format
        print (time.strftime("%d_%m_%Y"))

        dttime = time.strftime("%d_%m_%Y_%H_%M_%S")

        return dttime

    def create_directory(self,file):
        if not os.path.isdir(file):
            os.makedirs(file)
            print("Folder created successfully")
        else:
            print("Folder already exist.")


    def Add_Strings(self,Str1,Str2):
        str3 = Str1.strip() + Str2.strip()

        return str3

    def Build_File_Path(self,Str1,Str2):
        str3 = Str1.strip() + "/" +  Str2.strip()

        return str3

    def create_run_test_results_file(self,vTestResultsfile,vTestResultsheet):

        XLLibP3.Create_Workbook(vTestResultsfile,vTestResultsheet)
        XLLibP3.set_XL_cell_value(vTestResultsfile,vTestResultsheet,1,1,"TestCaseName")
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, 1, 2, "TestCaseDescription")
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, 1, 3, "Status")
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, 1, 4, "UpdatedDateTimeStamp")
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, 1, 5, "TestData")

    def create_test_case_results_file(self,vTestCaseResultsfile,vTestCaseResultsheet,vTCName,vTCDescription):
        XLLibP3.Create_Workbook(vTestCaseResultsfile, vTestCaseResultsheet)
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 1, 1, "TestCaseName")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 1, 2, vTCName)
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 1, 3, "TestCaseDescription")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 1, 4,vTCDescription)

        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 1, "Test Case Steps")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 2,"Action")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 3, "Expected Result")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 4, "Actual Result")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 5, "Execution Status")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 6, "Comments")
        XLLibP3.set_XL_cell_value(vTestCaseResultsfile, vTestCaseResultsheet, 3, 7, "DateTime")

    def update_run_test_results_file(self,vTestResultsfile, vTestResultsheet,irow,vtcname,vtcdescription,status,UpdatedDateTimeStamp,TestData):
        XLLibP3.Create_Workbook(vTestResultsfile, vTestResultsheet)
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, irow, 1, vtcname)
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, irow, 2, vtcdescription)
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, irow, 3, status)
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, irow, 4, UpdatedDateTimeStamp)
        XLLibP3.set_XL_cell_value(vTestResultsfile, vTestResultsheet, irow, 5, TestData)

    def get_test_case_row_number(self,file,sheetname,TCName):
        irow = 0
        i = 1

        imax = XLLibP3.get_XL_row_count(file, sheetname)

        for x in range(i, imax):
            if XLLibP3.get_XL_cell_value(file,sheetname,x,1) == TCName :
                irow = x
                break

        return irow

    def check_exists_by_xpath(self,driver,xpath):
        try:
            driver.find_element_by_xpath(xpath)
        except NoSuchElementException:
            return False
        return True

    def check_element_exists_by_xpath(driver,expath,timeout):
        try:
            element_present = EC.presence_of_element_located((By.XPATH, expath))
            WebDriverWait(driver, timeout).until(element_present)
        except TimeoutException:
            print("Timed out waiting for page to load")
            return False
        return True

    def check_element_exists_by_xpath(self,driver,eid,timeout):
        try:
            element_present = EC.presence_of_element_located((By.ID, eid))
            WebDriverWait(driver, timeout).until(element_present)
        except TimeoutException:
            print("Timed out waiting for page to load")
            return False
        return True

    def scrollDown(driver, value):
        driver.execute_script("window.scrollBy(0,"+str(value)+")")

    # Scroll down the page
    def scrollDownAllTheWay(self,driver):
        old_page = driver.page_source
        while True:
            logging.debug("Scrolling loop")
            for i in range(2):
                self.scrollDown(driver, 500)
                time.sleep(2)
            new_page = driver.page_source
            if new_page != old_page:
                old_page = new_page
            else:
                break
        return True

    def wait_for_page_element_to_be_visible_xpath(self,driver,expath,timeout) :
        element_visible = EC.visibilityOfElementLocated((By.XPATH , expath))
        WebDriverWait(driver, timeout).until(element_visible);


    def wait_for_page_element_to_be_visible_css(self,driver,expath,timeout) :
        element_visible = EC.visibilityOfElementLocated(expath)
        WebDriverWait(driver, timeout).until(element_visible);


    def check_element_exists_by_element(self,driver,eid,timeout):
        try:
            element_present = EC.presence_of_element_located(eid)
            WebDriverWait(driver, timeout).until(element_present)
            print("element found")
        except TimeoutException:
            print("Timed out waiting for page to load")
            return False
        return True