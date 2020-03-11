
from Sandbox.XLLibP3 import *
from Sandbox.GlobalVariables import *

class Readxl():
    glbldict1 = {'XLSheetName': 'DataSheet_Sales', 'XLFile': 'C:/QSTAF/DataBank/DataSheet_Sales_SFDC.xlsx'}
    xllib = XLLibp3()
    glblvar = Globalvariables()
    glblvar.glbldictupdate('XLFile','C:/QSTAF/DataBank/DataSheet_Sales_SFDC.xlsx')
    glbldict3 = glblvar.getdictvar()
    print(glbldict3)
    glblvar.glbldictupdate('XLSheetName', 'DataSheet_Sales')
    glbldict3 = glblvar.getdictvar()
    print(glbldict3)
    #glbldict2 = glblvar.setdictvar(glbldict1)
    #print(glbldict2)
   # for k, v in glbldict.items():
#    setattr(self, k, v)

    #glblvar = Globalvariables(glbldict1)
    #glbldict1['XLFile'] = 'C:/QSTAF/DataBank/DataSheet_Sales_SFDC.xlsx'
    #glbldict1['XLSheetName'] = 'DataSheet_Sales'
    #glblvar.glbldictupdate(glblvar,'XLFile','C:/QSTAF/DataBank/DataSheet_Sales_SFDC.xlsx')
    #glblvar.getdictvar()
    print(glbldict3['XLFile'])
    print(glbldict3['XLSheetName'])
    file = glbldict3['XLFile']
    sheet = glbldict3['XLSheetName']
  #  xllib.print_xl_cell_values(glbldict3['XLFile'], glbldict3['XLSheetName'], 1, 1)
 #   xllib.print_XL_cell_values(glbldict3['XLFile'], glbldict3['XLSheetName'], 1, 1)
    print(xllib.get_xl_cell_value_using_column_header(file, sheet, 2, "TC_ID"))
    print(xllib.get_xl_cell_values(glbldict3['XLFile'], glbldict3['XLSheetName'], 1, 1))
