
class Globalvariables():
    glbldict = {'XLSheetName': '', 'XLFile': ''}
    def __init__(self):
        #glbldict = {'XLSheetName': '', 'XLFile': ''}
        #self.glbldict = glbldict
        #for k, v in glbldict.items():
        #   setattr(self, k, v)

        #print(glbldict)
        pass

    def glbldictupdate(selfself,dictkey,dictvalue):
         upddict = Globalvariables.glbldict
         upddict[dictkey] = dictvalue
         #glbldict[dictkey] = dictvalue



    def  getdictvar(self):
        print(Globalvariables.glbldict)
        return Globalvariables.glbldict

    def setdictvar(self,dict):
        Globalvariables.glbldict = dict
        print(Globalvariables.glbldict)

    def Getdictvar(self):
        #Globalvariables.glbldict = dict
        #print(Globalvariables.glbldict)
        return Globalvariables.glbldict
    #def  setglobaldict:

     #  glbldict = {'XLSheetName':'','XLFile':''}