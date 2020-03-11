
from selenium import webdriver
from selenium.webdriver.support.ui import Select
import time
from SFDCPoC.Sandbox.utillib_new import *

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException


class CPQLib() :

# def get_webdriver_instance():
#     se2lib = BuiltIn().get_library_instance('Selenium2Library')
#     return se2lib._current_browser()

    def __init__(self, driver):
        self.driver = driver

    def expand_shadow_element(self,driver,element):
      shadow_root = driver.execute_script('return arguments[0].shadowRoot', element)
      return shadow_root

    def open_add_products_ribbon_Elements(self,driver) :
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver,root)

        time.sleep(4)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-line-editor')
        shadow_root1 = CPQLib.expand_shadow_element(driver,root1)

        time.sleep(4)


        return shadow_root1

    def pgconfigureproduts_click_add_products(self,driver) :
        shadow_root = CPQLib.open_add_products_ribbon_Elements(driver)

        root2 = shadow_root.find_element_by_css_selector('sb-custom-action[name="Add Products"]')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        Addproductsbutton = shadow_root2.find_element_by_css_selector('#mainButton')
        Addproductsbutton.click()

    def pgconfigureproduts_click_save(self,driver) :
        shadow_root = CPQLib.open_add_products_ribbon_Elements(driver)

        root2 = shadow_root.find_element_by_css_selector('sb-custom-action[name="Save"]')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        Addproductsbutton = shadow_root2.find_element_by_css_selector('#mainButton')
        Addproductsbutton.click()

    def pgconfigureproduts_click_delete_lines(Self,driver) :
        shadow_root = CPQLib.open_add_products_ribbon_Elements(driver)

        root2 = shadow_root.find_element_by_css_selector('sb-custom-action[name="Delete Lines"]')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        Addproductsbutton = shadow_root2.find_element_by_css_selector('#mainButton')
        Addproductsbutton.click()

    def pgconfigureproduts_click_calculate(self,driver) :
        shadow_root = CPQLib.open_add_products_ribbon_Elements(driver)

        root2 = shadow_root.find_element_by_css_selector('sb-custom-action[name="Calculate"]')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        Addproductsbutton = shadow_root2.find_element_by_css_selector('#mainButton')
        Addproductsbutton.click()


    def pgconfigureproduts_click_cancel(self,driver):
        shadow_root = CPQLib.open_add_products_ribbon_Elements(driver)


        root2 = shadow_root.find_element_by_css_selector('sb-custom-action[name="Save"]')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        Addproductsbutton = shadow_root2.find_element_by_css_selector('#mainButton')
        Addproductsbutton.click()

    def Decode_Select_Product_Nodes(self,driver) :
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        time.sleep(4)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#lookupLayout')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        # root3 = shadow_root2.find_element_by_css_selector('#list')
        # shadow_root3 = expand_shadow_element(driver, root3)

        return shadow_root2

    def Expand_product_list(self,driver,label,labelaction):
        root = CPQLib.Decode_Select_Product_Nodes(driver)

        lists = root.find_elements_by_css_selector('sb-table-row')
        tempindex = 0
        index = 0
        for list in lists:

            shadow_root1 = CPQLib.expand_shadow_element(driver, list)
            # time.sleep(4)

            root2 = shadow_root1.find_element_by_css_selector('#row')
            shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

            # time.sleep(4)

           # root9 = shadow_root8.find_element_by_css_selector('#g > div > sb-table-cell-select')
            root3 = shadow_root2.find_element_by_css_selector('sb-table-cell')
            shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

            # time.sleep(4)

            root4 = shadow_root3.find_element_by_css_selector('sb-field')
            shadow_root4 = CPQLib.expand_shadow_element(driver, root4)
            # time.sleep(4)
            root5 = shadow_root4.find_element_by_css_selector('sb-html')
            shadow_root5 = CPQLib.expand_shadow_element(driver, root5)
            # time.sleep(4)
            root6 = shadow_root5.find_element_by_css_selector('span')
            # print "Span text : " + str(root6.get_attribute("id"))
            # print "Span text : " + str(root6.text)
            # print "Span text : " + str(root6.get_attribute("text"))
            # root8.click()
            if str(root6.text) == label:
                if labelaction == 'Expand':
                    root6.click()
                elif labelaction == 'Select':

                    root7 = shadow_root1.find_element_by_css_selector('#selection')
                    shadow_root7 = CPQLib.expand_shadow_element(driver, root7)

                    root8 = shadow_root7.find_element_by_css_selector('sb-table-cell-select')
                    shadow_root8 = CPQLib.expand_shadow_element(driver, root8)

                    time.sleep(2)
                    root9 = shadow_root8.find_element_by_css_selector('#checkbox')
                    root9.click()


    def pgselectproduct_Header_Ribbon(driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        time.sleep(4)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-page-header')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        return root2

    def pgselectproduct_Click_Select_Button(self,driver):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('#plSelect')
        root1.click()

    def pgselectproduct_Click_Select_More_Button(self,driver):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('#plSelectMore')
        root1.click()


    def pgselectproduct_Click_Cancel_Button(self,driver):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('#plCancel')
        root1.click()

    def pgselectproduct_Search_product(self,driver,label):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('sb-search-bar')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-typeahead')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('#itemLabel')
        root3.click()
        root3.send_keys(label)


        root21 = shadow_root1.find_element_by_css_selector('#search')
        root21.click()

    def pgselectproduct_Click_Search(self,driver):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('sb-search-bar')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#search')
        root2.click()

    def pgconfigureproduts_expand_nodes(self,driver) :
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # time.sleep(4)
        root31 = shadow_root.find_element_by_css_selector('#content > sb-line-editor')
        shadow_root31 = CPQLib.expand_shadow_element(driver, root31)
        time.sleep(4)
        root1 = shadow_root31.find_element_by_css_selector('#groupLayout')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#Group_')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('#standardLines')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        return shadow_root3

    def pgconfigureproduts_select_product(self,driver, label):
            root = CPQLib.pgconfigureproduts_expand_nodes(driver)

            lists = root.find_elements_by_css_selector('sb-le-table-row')
            tempindex = 0
            index = 0
            for list in lists:
                shadow_root1 = CPQLib.expand_shadow_element(driver, list)
                # time.sleep(4)

                root2 = shadow_root1.find_element_by_css_selector('#row')
                shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

                root3 = shadow_root2.find_element_by_css_selector('sb-le-table-cell')
                shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

                # time.sleep(4)

                root4 = shadow_root3.find_element_by_css_selector('sb-field')
                shadow_root4 = CPQLib.expand_shadow_element(driver, root4)
                # time.sleep(4)
                root5 = shadow_root4.find_element_by_css_selector('sb-html')
                shadow_root5 = CPQLib.expand_shadow_element(driver, root5)
                # time.sleep(4)
                root6 = shadow_root5.find_element_by_css_selector('span')
                print("Span text : " + str(root6.get_attribute("id")))
                print("Span text : " + str(root6.text))
                print("Span text : " + str(root6.get_attribute("text")))
                # root8.click()
                if str(root6.text) == label:
                     # shadow_root1.find_element_by_css_selector('#selection').click()
                     # root7 = shadow_root1.find_element_by_css_selector('#selection')
                     # shadow_root7 = expand_shadow_element(driver, root7)


                     root8 = shadow_root1.find_element_by_css_selector('paper-checkbox')
                     shadow_root8 = CPQLib.expand_shadow_element(driver, root8)
                     time.sleep(20)

                     root9 = shadow_root8.find_element_by_css_selector('#checkboxContainer')

                     driver.execute_script('arguments[0].scrollIntoView()', root9)
                     time.sleep(5)
                     root9.click()

                     # root9 = shadow_root8.find_element_by_css_selector('paper-ripple')
                     # shadow_root9 = expand_shadow_element(driver, root9)

                     # dest_filename = 'c:/files/roo999.txt'
                     # fileo = open(dest_filename, 'w')
                     #
                     # fileo.writelines("********************************************************")
                     #
                     # fileo.writelines("********************************************************")
                     # fileo.writelines("\n root6 : " + str(root9.get_attribute("innerHTML")))
                     #
                     # fileo.close()

                     time.sleep(4)
                     # root8 = shadow_root7.find_element_by_css_selector('paper-checkbox')
                     # root9 = shadow_root8.find_element_by_css_selector('#checkboxContainer')
                     # root9.click()


    def pgconfigureproduts_Save_product(self,driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        time.sleep(4)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#pcSave')
        root2.click()


    def pgconfigureproduts_filter_product(self,driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        time.sleep(4)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#fb')
        root2.click()


    def pgconfigureproduts_Cancel_product(self,driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        time.sleep(4)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#pcCancel')
        root2.click()

    def pgselectproduct_Click_Filter_Button(self,driver):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('#fb')
        root1.click()

    def pgselectproduct_Expand_Filter_Section (self,driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        # root2 = shadow_root1.find_element_by_css_selector('sb-page-header')
        # shadow_root2 = expand_shadow_element(driver, root2)

        root3 = shadow_root1.find_element_by_css_selector('#pf')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        root4 = shadow_root3.find_element_by_css_selector('#panel')
        shadow_root4 = CPQLib.expand_shadow_element(driver, root4)

        return shadow_root4

    def pgselectproduct_Enter_Product_Number(self,driver,searchvalue) :


        root = CPQLib.pgselectproduct_Expand_Filter_Section (driver)

        root1 = root.find_element_by_css_selector('sb-filter-item[item="ProductCode.value"]')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#field')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('sb-input')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        root4 = shadow_root3.find_element_by_css_selector('#input')
        root4.click()
        root4.send_keys(searchvalue)


    def pgselectproduct_Enter_Product_Code(self,driver, searchvalue):
        root = CPQLib.pgselectproduct_Expand_Filter_Section(driver)

        root1 = root.find_element_by_css_selector('sb-filter-item[item="Name.value"]')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#field')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('sb-input')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        root4 = shadow_root3.find_element_by_css_selector('#input')
        root4.click()
        root4.send_keys(searchvalue)

    def pgselectproduct_Select_Product_Family(self,driver, selectvalue):
        root = CPQLib.pgselectproduct_Expand_Filter_Section(driver)

        root1 = root.find_element_by_css_selector('sb-filter-item[item="Family.value"]')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#field')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('sb-select')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        root4 = shadow_root3.find_element_by_css_selector('#select')
        root4.click()
        root4.select_by_visible_text(selectvalue)

    def pgselectproduct_Click_Apply_Filter_Button (self,driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#submit > sb-i18n')
        root2.click()

    def pgselectproduct_Click_Clear_Fields_in_Filter_Click(self,driver):
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('#clearfilter > sb-i18n')
        root2.click()

    def pgselectproduct_error_banner_root(self,driver):
            root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
            shadow_root = CPQLib.expand_shadow_element(driver, root)

            # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
            root1 = shadow_root.find_element_by_css_selector('sb-product-lookup')
            shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

            # root2 = shadow_root1.find_element_by_css_selector('#messages > sb-toast')
            root2 = shadow_root1.find_element_by_css_selector('sb-toast')
            shadow_root2 = CPQLib.expand_shadow_element(driver, root2)
            # root9 = shadow_root8.find_element_by_css_selector('paper-ripple')
            # shadow_root9 = expand_shadow_element(driver, root9)

            # dest_filename = 'c:/files/roo999.txt'
            # fileo = open(dest_filename, 'w')
            #
            # fileo.writelines("********************************************************")
            #
            #
            # fileo.writelines("\n root2 : " + str(root2.get_attribute("innerHTML")))
            #
            # fileo.writelines("********************************************************")
            #
            # fileo.close()

            time.sleep(4)

            # error_0 > div > h2
            errtext = 'y'
            # print "tu tu tuma : " + str(len(shadow_root2.find_elements_by_css_selector('div[id^="error_"]')))
            elelist = shadow_root2.find_elements_by_css_selector('div[id^="error_"]')

            for index in range(len(shadow_root2.find_elements_by_css_selector('div[id^="error_"]'))):
                root3 = elelist[index].find_element_by_css_selector('h2')
                print("index value is : "  + str(index))
                print("root3.textis : " + str(root3.text))
                errtext = errtext  +  '\n'
                errtext = errtext + str(root3.text)
                # errtext = errtext + '|' + str(root3.text)
                # errtext.append('|')
                # errtext.append(str(root3.text))

            # for index in range(len(shadow_root2.find_elements_by_css_selector('div[id^="error_"]'))):
            #     root3 = elelist[index].find_element_by_css_selector('i')
            #     root3.click()
            #     print  "tu 1  : " + str(root3.text)

    # def expand_pg_confogure_product_features(drivers):
    #
    #         return errtext

    def pgselectproduct_waitfor_Select_Button(self,driver):
        root = CPQLib.pgselectproduct_Header_Ribbon(driver)

        root1 = root.find_element_by_css_selector('#plSelect')

        while len(root.find_elements_by_css_selector('#plSelect')) == 0 :
            print("inwhile")
            time.sleep(3)
            root = CPQLib.pgselectproduct_Header_Ribbon(driver)

            root1 = root.find_element_by_css_selector('#plSelect')


        # Utillib.check_element_exists_by_element(driver, root1, 30)
        #
        # Utillib.wait_for_page_element_to_be_visible_css(driver, root1, 30)

    def pgselectproduct_checkfor_errors(self,driver):
        rettext = "-1"
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        root1 = shadow_root.find_element_by_css_selector('sb-product-lookup')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        # # root2 = shadow_root1.find_element_by_css_selector('#messages > sb-toast')
        # root2 = shadow_root1.find_element_by_css_selector('sb-toast')
        # shadow_root2 = expand_shadow_element(driver, root2)

        print("toast : " + str(len(shadow_root1.find_elements_by_css_selector('sb-toast'))))

        if len(shadow_root1.find_elements_by_css_selector('sb-toast')) == 0 :
            rettext = "-1"

        else:
            rettext = CPQLib.pgselectproduct_error_banner_root(driver)

        return rettext

    def pgselectproduct_close_errors(self,driver):
            root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
            shadow_root = CPQLib.expand_shadow_element(driver, root)

            # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
            root1 = shadow_root.find_element_by_css_selector('sb-product-lookup')
            shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

            # root2 = shadow_root1.find_element_by_css_selector('#messages > sb-toast')
            root2 = shadow_root1.find_element_by_css_selector('sb-toast')
            shadow_root2 = CPQLib.expand_shadow_element(driver, root2)


            time.sleep(4)

            root3 = shadow_root2.find_element_by_css_selector('i')
            root3.click()

    def pg_config_products_preconfig(self,driver):

        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-product-bundles-layout')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root21 = shadow_root2.find_element_by_css_selector('sb-product-feature-layout')
        shadow_root21 = CPQLib.expand_shadow_element(driver, root21)

        root3 = shadow_root21.find_element_by_css_selector('sb-product-feature-list')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)


        root4 = shadow_root3.find_element_by_css_selector('sb-product-feature')
        shadow_root4 = CPQLib.expand_shadow_element(driver, root4)



        root5 = shadow_root4.find_element_by_css_selector('sb-attribute-table')
        shadow_root5 = CPQLib.expand_shadow_element(driver, root5)

        root6 = shadow_root5.find_element_by_css_selector('sb-group')
        shadow_root6 = CPQLib.expand_shadow_element(driver, root6)

        root7 = shadow_root6.find_element_by_css_selector('sb-attribute-item')
        shadow_root7 = CPQLib.expand_shadow_element(driver, root7)

        root8 = shadow_root7.find_element_by_css_selector('sb-field')
        shadow_root8 = CPQLib.expand_shadow_element(driver, root8)

        root9 = shadow_root8.find_element_by_css_selector('sb-select')
        shadow_root9 = CPQLib.expand_shadow_element(driver, root9)

        eleselect = Select(shadow_root9.find_element_by_css_selector('select'))

        for option in eleselect.options:
            print(option.text, option.get_attribute('value'))

            # for index in range(len(shadow_root2.find_elements_by_css_selector('div[id^="error_"]'))):
            #     root3 = elelist[index].find_element_by_css_selector('h2')
            #     print "index value is : "  + str(index)
            #     print "root3.textis : " + str(root3.text)
            #     errtext = errtext  +  '\n'
            #     errtext = errtext + str(root3.text)


    def pg_configure_products_Expand_filterheader(self,driver) :
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-product-bundles-layout')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('sb-group')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        return shadow_root3

        # print " length : " + len(shadow_root1.find_elements_by_css_selector('sb-page-header'))
        # dest_filename = 'c:/files/roo999.txt'
        # fileo = open(dest_filename, 'w')
        #
        # fileo.writelines("********************************************************")
        # fileo.writelines("\n root6 : " + str(root1.get_attribute("innerHTML")))
        # fileo.writelines("********************************************************")
        #
        #
        # fileo.close()
        # filterele = shadow_root1.find_element_by_css_selector('sb-page-header')
        # filterele = shadow_root1.find_element_by_xpath("//*[@id='fb']")
        #
        # filterele.click()

    def pg_configure_products_Enter_product(self,driver,value) :

        root = CPQLib.pg_configure_products_Expand_filterheader(driver)


        root1 = root.find_element_by_css_selector('sb-product-bundles-filter-item[item="SBQQ__ProductCode__c"]')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-field')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('sb-input')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        inpele = shadow_root3.find_element_by_css_selector('input')
        inpele.click()
        inpele.send_keys(value)


    def pg_configure_products_filterheader_click_apply(self,driver) :
        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-product-bundles-layout')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root3 = shadow_root2.find_element_by_css_selector('paper-button')
        root3.click()



    def expand_pg_configure_products_pageheader(self,driver) :


        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-product-bundles-layout')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root21 = shadow_root2.find_element_by_css_selector('sb-product-feature-layout')
        shadow_root21 = CPQLib.expand_shadow_element(driver, root21)

        root3 = shadow_root21.find_element_by_css_selector('sb-product-feature-list')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)


        root4 = shadow_root3.find_element_by_css_selector('sb-product-feature')
        shadow_root4 = CPQLib.expand_shadow_element(driver, root4)

        root5 = shadow_root4.find_element_by_css_selector('sb-product-option-table')
        shadow_root5 = CPQLib.expand_shadow_element(driver, root5)

        return shadow_root5

    def  pg_config_select_product_feature(self,driver,label) :

        root = CPQLib.expand_pg_configure_products_pageheader(driver)

        rowlists = root.find_elements_by_css_selector('sb-table-row')
        print("list leb   "  + str(len(rowlists)))

        for rowlist in rowlists :

            # root1 = root.find_element_by_css_selector('sb-table-row')
            shadow_root1 = CPQLib.expand_shadow_element(driver, rowlist)
            print("joooo " + str(len(shadow_root1.find_elements_by_css_selector('#row'))))
            print("joooo " + str(len(shadow_root1.find_elements_by_css_selector('sb-group#row'))))
            root2 = shadow_root1.find_element_by_css_selector('#row')
            # root2 =  shadow_root1.find_element_by_css_selector('sb-group')
            shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

            # celllists = root2.find_elements_by_css_selector('sb-option-cell')
            celllists = shadow_root2.find_elements_by_css_selector('sb-option-cell')
            print("Cell leb   " + str(len(celllists)))

            for celllist in celllists:


                # root3 =  shadow_root2.find_element_by_css_selector('sb-option-cell')
                shadow_root3 = CPQLib.expand_shadow_element(driver, celllist)

                root4 = shadow_root3.find_element_by_css_selector('sb-field')
                shadow_root4 = CPQLib.expand_shadow_element(driver, root4)

                root5 = shadow_root4.find_element_by_css_selector('sb-html')
                shadow_root5 = CPQLib.expand_shadow_element(driver, root5)

                root6 = shadow_root5.find_element_by_css_selector('span')
                print("Span text : " + str(root6.get_attribute("text")))
                print("Span text : " + str(root6.text))
                if str(root6.text) == label:
                    root2 = shadow_root1.find_element_by_css_selector('#selection')
                    shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

                    root31 = shadow_root2.find_element_by_css_selector('sb-table-cell-select')
                    shadow_root31 = CPQLib.expand_shadow_element(driver, root31)

                    # root32 = shadow_root31.find_element_by_css_selector('paper-checkbox')
                    time.sleep(2)
                    root32 = shadow_root31.find_element_by_css_selector('#checkbox')
                    root32.click()
                    break

        # root1 = root.find_element_by_css_selector('sb-table-row')
        # shadow_root1 = expand_shadow_element(driver, root1)
        #
        # root2 =  shadow_root1.find_element_by_css_selector('sb-group')
        # shadow_root2 = expand_shadow_element(driver, root2)
        #
        #
        # root3 =  shadow_root2.find_element_by_css_selector('sb-option-cell')
        # shadow_root3 = expand_shadow_element(driver, root3)
        #
        # root4 = shadow_root3.find_element_by_css_selector('sb-field')
        # shadow_root4 = expand_shadow_element(driver, root4)
        #
        # root5 = shadow_root4.find_element_by_css_selector('sb-html')
        # shadow_root5 = expand_shadow_element(driver, root5)
        #
        # root31 =  shadow_root2.find_element_by_css_selector('sb-table-cell-select')
        # shadow_root31 = expand_shadow_element(driver, root31)
        #
        #




    def expand_pg_configure_products_pageheader_All(self,driver,label,labeloption) :

        index = 0
        tindex = 0
        ffound = 0

       # driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

        root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
        shadow_root = CPQLib.expand_shadow_element(driver, root)

        # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
        root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
        shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

        root2 = shadow_root1.find_element_by_css_selector('sb-product-bundles-layout')
        shadow_root2 = CPQLib.expand_shadow_element(driver, root2)

        root21 = shadow_root2.find_element_by_css_selector('sb-product-feature-layout')
        shadow_root21 = CPQLib.expand_shadow_element(driver, root21)

        root3 = shadow_root21.find_element_by_css_selector('sb-product-feature-list')
        shadow_root3 = CPQLib.expand_shadow_element(driver, root3)

        featurelists = shadow_root3.find_elements_by_css_selector('sb-product-feature')
        print("list leb   "  + str(len(featurelists)))

        for featurelist in featurelists :
            index = int(index) + int(1)
            print("index is : " + str(index))
            print("if value " + str((str(index)) == str(1)))
            if not (str(index)) == str(1) :
                print("I am in IF")
                # root4 = shadow_root3.find_element_by_css_selector('sb-product-feature')
                # root4 = shadow_root3.find_element_by_css_selector(featurelist)
                shadow_root4 = CPQLib.expand_shadow_element(driver, featurelist)
                print("shadow_root4 expanded")

                root5 = shadow_root4.find_element_by_css_selector('sb-product-option-table')
                shadow_root5 = CPQLib.expand_shadow_element(driver, root5)
                print("shadow_root5 expanded")

                rowlists = shadow_root5.find_elements_by_css_selector('sb-table-row')
                # print "list leb   "  + str(len(rowlists))

                for rowlist in rowlists :

                    # root1 = root.find_element_by_css_selector('sb-table-row')
                    shadow_root6 = CPQLib.expand_shadow_element(driver, rowlist)
                    print("shadow_root6 expanded")
                    # print "joooo " + str(len(shadow_root6.find_elements_by_css_selector('#row')))
                    # print "joooo " + str(len(shadow_root6.find_elements_by_css_selector('sb-group#row')))
                    root7 = shadow_root6.find_element_by_css_selector('#row')
                    # root2 =  shadow_root1.find_element_by_css_selector('sb-group')
                    shadow_root7 = CPQLib.expand_shadow_element(driver, root7)
                    print("shadow_root7 expanded")

                    # celllists = root2.find_elements_by_css_selector('sb-option-cell')
                    celllists = shadow_root7.find_elements_by_css_selector('sb-option-cell')
                    print("Cell leb   " + str(len(celllists)))

                    for celllist in celllists:


                        # root3 =  shadow_root2.find_element_by_css_selector('sb-option-cell')
                        shadow_root8 = CPQLib.expand_shadow_element(driver, celllist)

                        root9 = shadow_root8.find_element_by_css_selector('sb-field')
                        shadow_root9 = CPQLib.expand_shadow_element(driver, root9)

                        root10 = shadow_root9.find_element_by_css_selector('sb-html')
                        shadow_root10 = CPQLib.expand_shadow_element(driver, root10)

                        root11 = shadow_root10.find_element_by_css_selector('span')
                        print("Span text : " + str(root11.get_attribute("text")))
                        print("Span text : " + str(root11.text))
                        if str(root11.text) == label:
                            root12 = shadow_root6.find_element_by_css_selector('#selection')
                            shadow_root12 = CPQLib.expand_shadow_element(driver, root12)

                            root31 = shadow_root12.find_element_by_css_selector('sb-table-cell-select')
                            shadow_root31 = CPQLib.expand_shadow_element(driver, root31)

                            print(' labeloption is : ' +  labeloption)
                            # root32 = shadow_root31.find_element_by_css_selector('paper-checkbox')
                            if labeloption == 'Check':
                                time.sleep(2)
                                root32 = shadow_root31.find_element_by_css_selector('#checkbox')
                                driver.execute_script("return arguments[0].scrollIntoView(true);", root32)
                                root32.click()
                                break
                            elif labeloption == 'Radio':
                                print('i am in radio.')
                                time.sleep(2)
                                root32 = shadow_root31.find_element_by_css_selector('#radio')
                                driver.execute_script("return arguments[0].scrollIntoView(true);", root32)
                                root32.click()
                                break



    def pg_configure_product_Save(self,driver):
            root = driver.find_element_by_xpath("//sb-page-container[@id='sbPageContainer']")
            shadow_root = CPQLib.expand_shadow_element(driver, root)

            # root1 = shadow_root.find_element_by_css_selector('#content > sb-product-lookup')
            root1 = shadow_root.find_element_by_css_selector('#content > sb-product-config')
            shadow_root1 = CPQLib.expand_shadow_element(driver, root1)

            root2 = shadow_root1.find_element_by_css_selector('#pcSave > sb-i18n')
            driver.execute_script("return arguments[0].scrollIntoView(true);", root2)
            root2.click()

