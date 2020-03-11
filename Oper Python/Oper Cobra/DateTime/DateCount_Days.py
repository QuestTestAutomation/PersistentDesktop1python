import time
import datetime
from datetime import date
today = datetime.date.today()
#today
#datetime.date.toordinal()
#today == date.fromtimestamp(time.time())
#True
my_birthday = date(today.year, 4, 4)
print(my_birthday)
if my_birthday < today:
    my_birthday = my_birthday.replace(year=today.year + 1)
    my_birthday
#   datetime.date(2008, 6, 24)
time_to_birthday = abs(my_birthday - today)
#print(time_to_birthday.days)
print(time_to_birthday.days)
print(time_to_birthday.time)