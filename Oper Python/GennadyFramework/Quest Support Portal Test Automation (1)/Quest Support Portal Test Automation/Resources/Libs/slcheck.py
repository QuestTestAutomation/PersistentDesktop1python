from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
  
# This is the only code you need to edit in your existing scripts.
# The command_executor tells the test to run on Sauce, while the desired_capabilities
# parameter tells us which browsers and OS to spin up.

caps = {}
caps['deviceName'] = "Samsung Galaxy S9 WQHD GoogleAPI Emulator"
caps['deviceOrientation'] = "portrait"
caps['browserName'] = "Chrome"
caps['platformVersion'] = "7.1"
caps['platformName'] = "Android"


desired_cap = {
    'deviceName': "Samsung Galaxy S9 WQHD GoogleAPI Emulator",
    'deviceOrientation': "portrait",
    'browserName': "Chrome",
    'platformVersion': "7.1",
    'platformName': "Android",


    #'browserName':"Safari", 'platformName':"iOS", 'deviceName':"iPhone X Simulator",
}
driver = webdriver.Remote(
   command_executor='http://sso-quest-Gennady.Borodin:8d553dcb-3305-4247-b2c5-0acc04d8b376@ondemand.saucelabs.com:80/wd/hub',
   desired_capabilities=desired_cap)
  
# This is your test logic. You can add multiple tests here.
driver.get("http://www.google.com")
if not "Google" in driver.title:
    raise Exception("Unable to load google page!")
elem = driver.find_element_by_name("q")
elem.send_keys("Sauce Labs")
elem.submit()
print driver.title
  
# This is where you tell Sauce Labs to stop running tests on your behalf.
# It's important so that you aren't billed after your test finishes.
driver.quit()