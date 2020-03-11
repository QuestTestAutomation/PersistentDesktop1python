from datetime import datetime
from pytz import timezone
import pytz

date_format='%m/%d/%Y %H:%M:%S %Z'
date = datetime.now(tz=pytz.utc)
print('Current date & time is:', date.strftime(date_format))

date_PDT = date.astimezone(timezone('US/Pacific'))

print('Local date & time in Pacific is  :', date_PDT.strftime(date_format))

# Asia/Calcutta

date_India = date.astimezone(timezone('Asia/Calcutta'))

print('Local date & time in India is  :', date_India.strftime(date_format))

# Europe/Moscow

date_moscow = date.astimezone(timezone('Europe/Moscow'))

print('Local date & time in Moscow is  :', date_moscow.strftime(date_format))

# America/Panama

date_Panama = date.astimezone(timezone('America/Panama'))

print('Local date & time in Panama is  :', date_Panama.strftime(date_format))

# Asia/Tokyo

date_tokyo = date.astimezone(timezone('Asia/Tokyo'))

print('Local date & time in Tokyo is  :', date_tokyo.strftime(date_format))