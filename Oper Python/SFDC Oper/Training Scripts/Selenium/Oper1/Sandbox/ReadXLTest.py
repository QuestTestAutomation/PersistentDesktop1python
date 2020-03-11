from Sandbox.XLLibp3 import *
from Sandbox.Globalvariables import *


xllib = XLLibp3()
glblvar = Globalvariables()
#s = glblvar.setglobaldict()
#s['']
print(glblvar['XLFile'])
print(glblvar['XLSheetName'])
glblvar['XLFile'] = 'C:/QSTAF/DataBank/DataSheet_Sales_SFDC.xlsx'
glblvar['XLSheetName'] = 'DataSheet_Sales'
print(glblvar['XLFile'])
print(glblvar['XLSheetName'])
xllibp3.print_xl_cell_values(xllibp3,glblvar['XLFile'],glblvar['XLSheetName'],1,1)


