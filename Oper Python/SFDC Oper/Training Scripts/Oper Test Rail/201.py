from TestRailLibrary import TestRailLibrary

#class usetraillib(TestRailLibrary):

TLUrl = 'https://tr.labs.quest.com/testrail/'
user = 'seshikanth.anumolu@quest.com'
passw = 'P@ssw0rd@17'
project = 'Channel Business Management'

 #  def  __init__(self):

client = TestRailLibrary(TLUrl,user,passw)
projectid = client.Get_TestRail_ProjectID(client,project)
print(projectid)
runs = client.Get_TestRail_ProjectRuns(client,project)
print(runs)

run1 = clien.Create_Test_Run_with_all_cases(client, project, 'fourthrun' ,'fourthrun'):
print(run1)



