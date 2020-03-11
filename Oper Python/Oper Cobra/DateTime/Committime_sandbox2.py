


from DateTime.committimevalidation import *
import datetime
import time
import pytz



localtime = pytz.timezone('US/Pacific')
Opendt12 = '7/15/2016 8:46:04 PM'
SupportLevel = 'Standard'
Severity = 'Level 3'

Country = 'AMER'
#Opendt24 = datetime.datetime.strptime(pendt12,'%m/%d/%Y %I:%M:%S %p').strftime('%m/%d/%Y %H:%M:%S')
Opendt24 = datetime.datetime.strptime(Opendt12,'%m/%d/%Y %I:%M:%S %p')
Opendt24_dt = Opendt24.date()
Opendt24_tm = Opendt24.time()
Srzone_Opendt = ' '

Open24_isDST = localtime.localize(Opendt24)
print(bool(Open24_isDST.dst()))

print(Opendt12)
print(Opendt24)
print(Opendt24_dt)
#print(time.localtime(Opendt24).tm_isdst)
#print(time.localtime(Opendt24).tm_isdst)
if Country == 'AMER' :
    print(Opendt24_dt.weekday())
    if Opendt24_dt.weekday() == 5 :
        Opendt24_dt = Opendt24_dt + datetime.timedelta(days=2)
    elif Opendt24_dt.weekday() == 6 :
        Opendt24_dt = Opendt24_dt + datetime.timedelta(days=1)

    Srzone_Opendt = datetime.datetime.combine(Opendt24_dt, datetime.time(5, 00, 00))
    Srzone_Closeddt = datetime.datetime.combine(Opendt24_dt, datetime.time(17, 00, 00))
    print('SR Open Date : ', Srzone_Opendt)
    print('SR Close Date : ', Srzone_Closeddt)



elif Country == 'EMEA' :
    if Opendt24_dt.weekday() == 5 :
        Opendt24_dt = Opendt24_dt + datetime.timedelta(days=2)
    elif Opendt24_dt.weekday() == 6 :
        Opendt24_dt = Opendt24_dt + datetime.timedelta(days=1)

    Srzone_Opendt = datetime.datetime.combine(Opendt24_dt, datetime.time(00, 00, 00))
    Srzone_Closeddt = datetime.datetime.combine(Opendt24_dt, datetime.time(9, 30, 00))
    print('SR Open Date : ', Srzone_Opendt)
    print('SR Close Date : ', Srzone_Closeddt)
elif Country == 'JAPAN' :
    if Opendt24_dt.weekday() == 6 :
        Opendt24_dt = Opendt24_dt + datetime.timedelta(days=1)


    if bool(Open24_isDST.dst()):
        Srzone_Opendt = datetime.datetime.combine(Opendt24_dt,datetime.time(16,00,00))
        Srzone_Closeddt = datetime.datetime.combine((Opendt24_dt +  datetime.timedelta(days=1)), datetime.time(1, 00, 00))
        print('SR Open Date : ',Srzone_Opendt)
        print('SR Close Date : ', Srzone_Closeddt)
    else:
        Srzone_Opendt = datetime.datetime.combine(Opendt24_dt, datetime.time(17, 00, 00))
        Srzone_Closeddt = datetime.datetime.combine((Opendt24_dt +  datetime.timedelta(days=1)), datetime.time(2, 00, 00))
        print('SR Open Date : ', Srzone_Opendt)
        print('SR Close Date : ', Srzone_Closeddt)
elif Country == 'APAC' :
    if Opendt24_dt.weekday() == 6 :
        Opendt24_dt = Opendt24_dt + datetime.timedelta(days=1)

    if bool(Open24_isDST.dst()):
        Srzone_Opendt = datetime.datetime.combine(Opendt24_dt,datetime.time(14,00,00))
        Srzone_Closeddt = datetime.datetime.combine((Opendt24_dt + datetime.timedelta(days=1)), datetime.time(1, 00, 00))
        print('SR Open Date : ', Srzone_Opendt)
        print('SR Close Date : ', Srzone_Closeddt)
    else:
        Srzone_Opendt = datetime.datetime.combine(Opendt24_dt, datetime.time(15, 00, 00))
        Srzone_Closeddt = datetime.datetime.combine((Opendt24_dt +  datetime.timedelta(days=1)), datetime.time(2, 00, 00))
        print('SR Open Date : ',Srzone_Opendt)
        print('SR Close Date : ', Srzone_Closeddt)

#Srzone_Opendt_conv = .strftime('%m/%d/%Y %H:%M:%S')datetime.strptime(Srzone_Opendt,'%m/%d/%Y %H:%M:%S').strftime('%m/%d/%Y %H:%M:%S')
if Opendt24 > Srzone_Opendt:
    print(Opendt24)
    print(Srzone_Opendt)
    print("Grater")
elif Opendt24 < Srzone_Opendt:
    print(Opendt24)
    print(Srzone_Opendt)
    print("Lesser")
print("Srzone_Opendt < Opendt24", Srzone_Opendt < Opendt24)
print("Opendt24 > Srzone_Closeddt", Opendt24 > Srzone_Closeddt)
if Srzone_Opendt < Opendt24 and Opendt24 < Srzone_Closeddt:
    Srcommit_stdt = Opendt24

    print('Hurray')


elif Srzone_Opendt == Opendt24:
    Srcommit_stdt = Srzone_Opendt
elif Opendt24 >  Srzone_Closeddt:


#elif Srzone_Closeddt >= Opendt24:
#    Srcommit_stdt = Srzone_Opendt
else:
    print('Murray')
#Set Commit time
if (SupportLevel.lower() == 'standard'.lower()) and (Severity.lower() == 'level 1'.lower()):
    SLACommittime = 60
elif (SupportLevel.lower() == 'standard'.lower()) and (Severity.lower() == 'level 2'.lower()):
    SLACommittime = 120
elif (SupportLevel.lower() == 'standard'.lower()) and (Severity.lower() == 'level 3'.lower()):
    SLACommittime = 240
elif (SupportLevel.lower() == 'standard'.lower()) and (Severity.lower() == 'level 4'.lower()):
    SLACommittime = 480
elif (SupportLevel.lower() == 'premier'.lower()) and (Severity.lower() == 'level 1'.lower()):
    SLACommittime = 30
elif (SupportLevel.lower() == 'premier'.lower()) and (Severity.lower() == 'level 2'.lower()):
    SLACommittime = 60
elif (SupportLevel.lower() == 'premier'.lower()) and (Severity.lower() == 'level 3'.lower()):
    SLACommittime = 120
elif (SupportLevel.lower() == 'premier'.lower()) and (Severity.lower() == 'level 3'.lower()):
    SLACommittime = 240
else :
    SLACommittime = 'Error while determining the commit hours'

print('SLACommittime :',SLACommittime)



print('Commit Start date time : ',Srcommit_stdt )
print('Hurray')

#print('commitdelta seconds: ', commitdelta.total_seconds())
#print('commitdelta hours: ', (int(commitdelta.total_seconds()/3600)))
#print('remaining seconds after hours : ', int(commitdelta.total_seconds()%3600) )
#print('minutes after hours : ', int((int(commitdelta.total_seconds()%3600))/60))
#print('remaining seconds after hours and minutes : ', int((int(commitdelta.total_seconds()%3600))%60))
#print('commitdelta days: ', commitdelta.days)
#print('commitdelta hours ', commitdelta.hours)
#print('commitdelta minutes ', int((commitdelta.total_seconds() // 60) % 60))
#print('commitdelta seconds ', commitdelta.seconds)

# Calculate commit time
committime_hours = (SLACommittime / 60)
print('committime_hours : ', committime_hours)
Srcommit_Closeddt = Srcommit_stdt + datetime.timedelta(hours=int(committime_hours))
print('Srcommit_Closeddt : ', Srcommit_Closeddt)
commitdelta = Srzone_Closeddt - Srcommit_stdt
usedhours = (int(int(commitdelta.total_seconds() / 3600)))
usedmins = (int(int(commitdelta.total_seconds() % 3600)) / 60)
usedsec = (int(int(commitdelta.total_seconds() % 3600)) % 60)



if Srcommit_Closeddt == Srzone_Closeddt:
    tempfinalcommittime = Srcommit_Closeddt
elif Srcommit_Closeddt < Srzone_Closeddt:
    tempfinalcommittime = Srcommit_stdt + datetime.timedelta(hours=committime_hours)
elif Srcommit_Closeddt > Srzone_Closeddt:
      cmttmval = committimevalidation()
      DateDict_a = committimevalidation.Set_Nextworkingday_Start_End_Datetime(cmttmval,Country,Srcommit_Closeddt)
      print('DateDict_a : ', DateDict_a)
      print(DateDict_a.get('start_datetime'))
      print('commitdelta :', commitdelta.total_seconds())
 #     cmtdelta = (datetime.datetime.strptime('Srzone_Closeddt','%Y-%m-%d %H:%M:%S')) - (datetime.datetime.strptime('Srcommit_stdt','%Y-%m-%d %H:%M:%S'))
 #     commitdelta = datetime.datetime.strptime(DateDict_a.get('Srzone_Closeddt'),'%m/%d/%Y %H:%M:%S') - datetime.datetime.strptime(Srzone_Closeddt,'%m/%d/%Y %H:%M:%S'))
 #     commitdel = Srzone_Closeddt - Srzone_Closeddt
 #     remhours = (int(cmtdelta.total_seconds() / 3600)))

      print('remhours ', usedhours)
      print(int(usedmins))
      print(usedsec)
      print(committime_hours)
  #    dayhours = (((datetime.datetime.strptime(DateDict_a.get('start_datetime'),'%Y-%m-%d %H:%M:%S')) - (datetime.datetime.strptime(DateDict_a.get('End_datetime'),'%Y-%m-%d %H:%M:%S')))/3600)
  #    dayhours = int((DateDict_a.get('start_datetime').strptime(DateDict_a.get('start_datetime'),'%Y-%m-%d %H:%M:%S') - DateDict_a.get('End_datetime').strftime(DateDict_a.get('End_datetime'),'%Y-%m-%d %H:%M:%S')) / 3600)
      stdate = DateDict_a.get('start_datetime')
      eddate = DateDict_a.get('End_datetime')
      dayhoursdelta =  eddate - stdate
  #    dayhoursdelta = int(int(datetime.datetime(DateDict_a.get('start_datetime'))) - int(datetime.datetime(DateDict_a.get('End_datetime'))))
      print('dayhoursdelta  : ' , dayhoursdelta)
      dayhours = (int(dayhoursdelta.seconds/3600))
      print('hello')
      print('dayhours ',int(dayhours))
      needhours = int(committime_hours - usedhours)
      print('needhours ', needhours)
      while needhours > dayhours:
          usedhours = usedhours + dayhours
          DateDict_a = committimevalidation.Set_Nextworkingday_Start_End_Datetime(cmttmval, Country, Srcommit_Closeddt)
          stdate = DateDict_a.get('start_datetime')
          eddate = usedhours =DateDict_a.get('End_datetime')
          dayhoursdelta = eddate - stdate
          dayhours = (int(dayhoursdelta.seconds / 3600))
          needhours = int(committime_hours - usedhours)

          needhours = int(committime_hours - usedhours)

      tempfinalcommittime = stdate + datetime.timedelta(hours=needhours)
if int(usedmins) > 0 :
    tempfinalcommittime = tempfinalcommittime + datetime.timedelta(minutes=usedmins)
if  int(usedsec) > 0 :
    tempfinalcommittime = tempfinalcommittime + datetime.timedelta(seconds=usedsec)
    print('tempfinalcommittime  ',tempfinalcommittime)
    tempfinalcommittime = tempfinalcommittime - datetime.timedelta(seconds=1)
    finalcommittime = tempfinalcommittime.strftime('%m/%d/%Y %I:%M:%S %p')
    print('tempfinalcommittime  ', tempfinalcommittime)
    print('finalcommittime :',finalcommittime)
  #    if committime_hours > usedhours
 #     finalcommittime = DateDict_a.get('start_datetime')