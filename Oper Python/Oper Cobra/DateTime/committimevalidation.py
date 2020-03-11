import datetime
import time
import pytz

class committimevalidation():
    
    def __init__(self):
        pass
    
    
    def Set_Nextworkingday_Start_End_Datetime(self,srcountry,srdate):
        localtime = pytz.timezone('US/Pacific')
        srdate_isDST = localtime.localize(srdate)
        if srcountry == 'AMER' :
            print(srdate.weekday())
            if srdate.weekday() == 5 :
                srdate = srdate + datetime.timedelta(days=2)
            elif srdate.weekday() == 6 :
                srdate = srdate + datetime.timedelta(days=1)

            Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(5, 00, 00))
            Srzone_Closeddt = datetime.datetime.combine(srdate, datetime.time(17, 00, 00))
            print('SR Open Date : ', Srzone_Opendt)
            print('SR Close Date : ', Srzone_Closeddt)
        elif srcountry == 'EMEA' :
            if srdate.weekday() == 5 :
                srdate = srdate + datetime.timedelta(days=2)
            elif srdate.weekday() == 6 :
                srdate = srdate + datetime.timedelta(days=1)

            Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(00, 00, 00))
            Srzone_Closeddt = datetime.datetime.combine(srdate, datetime.time(9, 30, 00))
            print('SR Open Date : ', Srzone_Opendt)
            print('SR Close Date : ', Srzone_Closeddt)
        elif srcountry == 'JAPAN' :
            if srdate.weekday() == 6 :
                srdate = srdate + datetime.timedelta(days=1)


            if bool(srdate_isDST.dst()):
                Srzone_Opendt = datetime.datetime.combine(srdate,datetime.time(16,00,00))
                Srzone_Closeddt = datetime.datetime.combine((srdate +  datetime.timedelta(days=1)), datetime.time(1, 00, 00))
                print('SR Open Date : ',Srzone_Opendt)
                print('SR Close Date : ', Srzone_Closeddt)
            else:
                Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(17, 00, 00))
                Srzone_Closeddt = datetime.datetime.combine((srdate +  datetime.timedelta(days=1)), datetime.time(2, 00, 00))
                print('SR Open Date : ', Srzone_Opendt)
                print('SR Close Date : ', Srzone_Closeddt)
        elif srcountry == 'APAC' :
            if srdate.weekday() == 6 :
                srdate = srdate + datetime.timedelta(days=1)

            if bool(srdate_isDST.dst()):
                Srzone_Opendt = datetime.datetime.combine(srdate,datetime.time(14,00,00))
                Srzone_Closeddt = datetime.datetime.combine((srdate + datetime.timedelta(days=1)), datetime.time(1, 00, 00))
                print('SR Open Date : ', Srzone_Opendt)
                print('SR Close Date : ', Srzone_Closeddt)
            else:

                Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(15, 00, 00))
                Srzone_Closeddt = datetime.datetime.combine((srdate +  datetime.timedelta(days=1)), datetime.time(2, 00, 00))
                print('SR Open Date : ',Srzone_Opendt)
                print('SR Close Date : ', Srzone_Closeddt)
        DateDict = {'start_datetime' : Srzone_Opendt, 'End_datetime' :Srzone_Closeddt}
        return DateDict

    def Get_the_Commit_Start_Datetime(self,srcountry,srdate):
        localtime = pytz.timezone('US/Pacific')
        srdate_isDST = localtime.localize(srdate)
        Srzone_Opendt = ' '
        Srzone_Closeddt = ' '
        if srcountry == 'AMER' :
             print(srdate.weekday())
             if srdate.weekday() == 5 :
                 srdate = srdate + datetime.timedelta(days=2)
             elif srdate.weekday() == 6 :
                srdate = srdate + datetime.timedelta(days=1)

             Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(5, 00, 00))
             Srzone_Closeddt = datetime.datetime.combine(srdate, datetime.time(17, 00, 00))
             if srdate <= Srzone_Opendt:
                 print(' I am in srdate <= Srzone_Opendt ')
                 Srnextworkingday = Srzone_Opendt
                 srcommit_stdate = Srzone_Opendt
             elif (Srzone_Opendt < srdate) and  (srdate <= Srzone_Closeddt):
                 print(' I am in (Srzone_Opendt < srdate) and  (srdate <= Srzone_Closeddt) ')
                 Srnextworkingday = srdate
                 rcommit_stdate = srdate
             elif (srdate > Srzone_Closeddt) :
                 print(' I am in (srdate > Srzone_Closeddt) ')
                 AMERworking = (0,1,2,3,4)
                 Srnextworkingday = Srzone_Opendt +  datetime.timedelta(days=1)
                 srcommit_stdate = Srnextworkingday
                 print('Srnextworkingday  :',Srnextworkingday)
                 print('Srzone_Opendt : ', Srzone_Opendt)
                 while (Srnextworkingday.weekday()) not in AMERworking:
                     print('Srzone_Opendt : ', Srzone_Opendt)
                     print('Srnextworkingday.weekday() :',Srnextworkingday.weekday())
                     Srnextworkingday =  Srnextworkingday + datetime.timedelta(days=1)
                     srcommit_stdate = Srnextworkingday
             print('srcommit_stdate : ', srcommit_stdate)
             Srzone_Opendt = datetime.datetime.combine(Srnextworkingday.date(), datetime.time(5, 00, 00))
             Srzone_Closeddt = datetime.datetime.combine(Srnextworkingday.date(), datetime.time(17, 00, 00))
        elif srcountry == 'EMEA' :
             SRCommit_Start_Datetime = ' '
             if srdate.weekday() == 5 :
                 srdate = srdate + datetime.timedelta(days=2)
             elif srdate.weekday() == 6 :
                 srdate = srdate + datetime.timedelta(days=1)

             Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(00, 00, 00))
             Srzone_Closeddt = datetime.datetime.combine(srdate, datetime.time(9, 30, 00))
             print('SR Open Date : ', Srzone_Opendt)
             print('SR Close Date : ', Srzone_Closeddt)
             if srdate <= Srzone_Opendt:
                 Srnextworkingday = Srzone_Opendt
                 srcommit_stdate = Srzone_Opendt
             elif (Srzone_Opendt < srdate) and  (srdate <= Srzone_Closeddt):
                 Srnextworkingday = srdate
                 srcommit_stdate = srdate
             elif (srdate > Srzone_Closeddt) :
                 AMERworking = (0,1,2,3,4)
                 Srnextworkingday = Srzone_Opendt +  datetime.timedelta(days=1)
                 print('Srzone_Opendt : ', Srzone_Opendt)
                 while (Srnextworkingday.weekday()) not in AMERworking:
                     print('Srzone_Opendt : ', Srzone_Opendt)
                     print('Srnextworkingday.weekday() :',Srnextworkingday.weekday())
                     Srnextworkingday =  Srnextworkingday + datetime.timedelta(days=1)
                     srcommit_stdate = Srnextworkingday
             print('srcommit_stdate : ', srcommit_stdate)
             Srzone_Opendt = datetime.datetime.combine(Srnextworkingday.date(), datetime.time(00, 00, 00))
             Srzone_Closeddt = datetime.datetime.combine(Srnextworkingday.date(), datetime.time(9, 30, 00))
        elif srcountry == 'JAPAN' :
              if srdate.weekday() == 6 :
                 srdate = srdate + datetime.timedelta(days=1)


                 if bool(srdate_isDST.dst()):
                    Srzone_Opendt = datetime.datetime.combine(srdate,datetime.time(16,00,00))
                    Srzone_Closeddt = datetime.datetime.combine((srdate +  datetime.timedelta(days=1)), datetime.time(1, 00, 00))
                    print('SR Open Date : ',Srzone_Opendt)
                    print('SR Close Date : ', Srzone_Closeddt)
                 else:
                    Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(17, 00, 00))
                    Srzone_Closeddt = datetime.datetime.combine((srdate +  datetime.timedelta(days=1)), datetime.time(2, 00, 00))
                    print('SR Open Date : ', Srzone_Opendt)
                    print('SR Close Date : ', Srzone_Closeddt)
        elif srcountry == 'APAC' :

              if srdate.weekday() == 6 :
                srdate = srdate + datetime.timedelta(days=1)

                if bool(srdate_isDST.dst()):
                    Srzone_Opendt = datetime.datetime.combine(srdate,datetime.time(14,00,00))
                    Srzone_Closeddt = datetime.datetime.combine((srdate + datetime.timedelta(days=1)), datetime.time(1, 00, 00))
                    print('SR Open Date : ', Srzone_Opendt)
                    print('SR Close Date : ', Srzone_Closeddt)
                else:

                    Srzone_Opendt = datetime.datetime.combine(srdate, datetime.time(15, 00, 00))
                    Srzone_Closeddt = datetime.datetime.combine((srdate +  datetime.timedelta(days=1)), datetime.time(2, 00, 00))
                    print('SR Open Date : ',Srzone_Opendt)
                    print('SR Close Date : ', Srzone_Closeddt)
        DateDict = {'start_datetime' : Srzone_Opendt, 'End_datetime' :Srzone_Closeddt, 'SRCommit_Start_Datetime' : srcommit_stdate }
        return DateDict

        