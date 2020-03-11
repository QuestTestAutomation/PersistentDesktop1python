
from DateTime.committimevalidation import *
import datetime
import time
import pytz



localtime = pytz.timezone('US/Pacific')
Opendt12 = '5/1/2018 10:41:14 PM'
SupportLevel = 'Premier'
Severity = 'Level 3'

Country = 'AMER'
# Opendt24 = datetime.datetime.strptime(pendt12,'%m/%d/%Y %I:%M:%S %p').strftime('%m/%d/%Y %H:%M:%S')
Opendt24 = datetime.datetime.strptime(Opendt12 ,'%m/%d/%Y %I:%M:%S %p')
Opendt24_dt = Opendt24.date()
Opendt24_tm = Opendt24.time()
#Srzone_Opendt = ' '
cmttmval = committimevalidation()
DateDict_a = committimevalidation.Get_the_Commit_Start_Datetime(cmttmval, Country, Opendt24)
Srzone_Opendt = DateDict_a.get('start_datetime')
Srzone_Closeddt = DateDict_a.get('End_datetime')

Srcommit_stdt = DateDict_a.get('SRCommit_Start_Datetime')
print('hhuhuhu',Srcommit_stdt)




Open24_isDST = localtime.localize(Opendt24)
print(bool(Open24_isDST.dst()))

print(Opendt12)
print(Opendt24)
print(Opendt24_dt)
# print(time.localtime(Opendt24).tm_isdst)
# print(time.localtime(Opendt24).tm_isdst)

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

print('SLACommittime :' ,SLACommittime)



print('Commit Start date time : ' ,Srcommit_stdt )

# Calculate commit time
committime_hours = int(SLACommittime / 60)
print('committime_hours : ', committime_hours)
Srcommit_Closeddt = Srcommit_stdt + datetime.timedelta(hours=committime_hours)
print('Srcommit_Closeddt : ', Srcommit_Closeddt)




if Srcommit_Closeddt == Srzone_Closeddt:
    tempfinalcommittime = Srcommit_Closeddt
    commitdelta = Srcommit_Closeddt - Srcommit_stdt
    usedhours = (int(int(commitdelta.total_seconds() / 3600)))
    usedmins = (int(int(commitdelta.total_seconds() % 3600)) / 60)
    usedsec = (int(int(commitdelta.total_seconds() % 3600)) % 60)
elif Srcommit_Closeddt < Srzone_Closeddt:
    tempfinalcommittime = Srcommit_stdt + datetime.timedelta(hours=committime_hours)
    commitdelta =  tempfinalcommittime - Srcommit_stdt
    usedhours = (int(int(commitdelta.total_seconds() / 3600)))
    usedmins = (int(int(commitdelta.total_seconds() % 3600)) / 60)
    usedsec = (int(int(commitdelta.total_seconds() % 3600)) % 60)
elif Srcommit_Closeddt > Srzone_Closeddt:
    cmttmval = committimevalidation()
    DateDict_a = committimevalidation.Set_Nextworkingday_Start_End_Datetime(cmttmval ,Country ,Srcommit_Closeddt)
    print('DateDict_a : ', DateDict_a)
    print(DateDict_a.get('start_datetime'))

    #     cmtdelta = (datetime.datetime.strptime('Srzone_Closeddt','%Y-%m-%d %H:%M:%S')) - (datetime.datetime.strptime('Srcommit_stdt','%Y-%m-%d %H:%M:%S'))
    #     commitdelta = datetime.datetime.strptime(DateDict_a.get('Srzone_Closeddt'),'%m/%d/%Y %H:%M:%S') - datetime.datetime.strptime(Srzone_Closeddt,'%m/%d/%Y %H:%M:%S'))
    #     commitdel = Srzone_Closeddt - Srzone_Closeddt
    #     remhours = (int(cmtdelta.total_seconds() / 3600)))
    commitdelta = Srzone_Closeddt - Srcommit_stdt
    print('commitdelta :', commitdelta.total_seconds())
    usedhours = (int(int(commitdelta.total_seconds() / 3600)))
    usedmins = (int(int(commitdelta.total_seconds() % 3600)) / 60)
    usedsec = (int(int(commitdelta.total_seconds() % 3600)) % 60)
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
    dayhours = (int(dayhoursdelta.seconds /3600))
    print('hello')
    print('dayhours ' ,int(dayhours))
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
if int(usedmins) > 0:
    tempfinalcommittime = tempfinalcommittime + datetime.timedelta(minutes=usedmins)
if int(usedsec) > 0:
    tempfinalcommittime = tempfinalcommittime + datetime.timedelta(seconds=usedsec)
    print('tempfinalcommittime  ', tempfinalcommittime)
tempfinalcommittime = tempfinalcommittime - datetime.timedelta(seconds=1)
finalcommittime = tempfinalcommittime.strftime('%m/%d/%Y %I:%M:%S %p')
print('tempfinalcommittime  ', tempfinalcommittime)
print('finalcommittime :', finalcommittime)
#    if committime_hours > usedhours
#     finalcommittime = DateDict_a.get('start_datetime')