
from testrail import *

class TRLib(APIClient) :



client = APIClient('http://tr.labs.quest.com/testrail/')
client.user = 'seshikanth.anumolu@quest.com'
client.password = 'P@ssw0rd@17'
case = client.send_get('get_case/C21742')
print(case)