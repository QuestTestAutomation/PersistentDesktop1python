import datetime

t1 = datetime.datetime.now() + datetime.timedelta(hours=1)
print(datetime.datetime.now())
print(t1)

datetime_object = datetime.datetime.strptime('1 June 2005','%d %B %Y')
s = datetime_object.strftime("%d/%m/%y")
print(s)

dt = '11/16/2010 10:10:49 AM'
dt1 = datetime.datetime.strptime('11/16/2010 10:10:49 AM','%m/%d/%Y %I:%M:%S %p').strftime('%m/%d/%Y %H:%M:%S')
dt2 = datetime.datetime.strptime('11/16/2010 10:10:49 PM','%m/%d/%Y %I:%M:%S %p').strftime('%m/%d/%Y %H:%M:%S')
print(dt)
print(dt1)
print(dt2)
dt3 = datetime.datetime.strptime('11/16/2010 10:10:49 PM','%m/%d/%Y')
print(dt3)

#dtf = dt.strftime('%m/%d/%Y %H:%M:%S')
today = datetime.date.today().strftime('%m/%d/%Y %H:%M:%S')
today1 = datetime.date(today)
print(today)
if dt1 < today:
    print('true')
elif dt1 > today:
    print('1')
else:
    print('false')

if dt3 < today1:
    print('true')
elif dt3 > today1:
    print('1')
else:
    print('false')

