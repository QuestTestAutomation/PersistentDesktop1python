import datetime

today = datetime.date.today()
print('Today    :', today)

one_day = datetime.timedelta(days=1)
print('One day  :', one_day)

yesterday = today - one_day
print('Yesterday:', yesterday)

tomorrow = today + one_day
print('Tomorrow :', tomorrow)

print()
print('tomorrow - yesterday:', tomorrow - yesterday)
print('yesterday - tomorrow:', yesterday - tomorrow)

one_day = datetime.timedelta(days=1)
print('1 day    :', one_day)
print('5 days   :', one_day * 5)
print('1.5 days :', one_day * 1.5)
print('1/4 day  :', one_day / 4)

# assume an hour for lunch
work_day = datetime.timedelta(hours=8)
meeting_length = datetime.timedelta(hours=2)
print('meetings per day :', work_day / meeting_length)

today = datetime.date.today()
print(today)
print('ctime  :', today.ctime())
ntime = today.ctime() + datetime.timedelta(hours=2)
print('ntime  :', ntime)