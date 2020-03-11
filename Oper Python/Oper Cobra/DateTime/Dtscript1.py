from datetime import datetime, timedelta

# create a new date (January 6, 2013 - 20:30)
myDate = datetime(2013, 1, 6, 20, 30)

# ok... a little date "introspection":
print('year: ' + myDate.year)  # (prints "2013")
print('month: ' + myDate.month)  # (prints "1")
print('day: ' + myDate.day)  # (prints "6")
print('hours: ' + myDate.hour)  # (prints "20")
print('minutes: ' + myDate.minute)  # (prints "30")

# go 12 hours back from "myDate"
twelveHoursBefore = myDate - timedelta(hours=12)

# twelveHoursBefore is equal to myDate, but "hour" prints "8"
print('12 hours before, hours were: ' + twelveHoursBefore.hour)

# go 20 minutes after "myDate"
twentyMinAfter = myDate + timedelta(minutes=20)

# twentyMinAfter is equal to myDate, but "minute" prints "50" (30 + 20)
print('20 minutes after, minutes are: ' + twentyMinAfter.minute)