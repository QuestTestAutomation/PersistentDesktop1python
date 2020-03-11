import datetime
today = datetime.date.today()
today_time = datetime.time(datetime.now())
print(today)
print(today.weekday())
print(today_time)
my_time = datetime.datetime.strptime(today_time, '%m/%d/%y')
#my_time = my_time + datetime.timedelta(hours=3,minutes=59)
print(my_time)