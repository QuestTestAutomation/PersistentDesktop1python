from TestRailLibrary import TestRailLibrary
from pprint import pprint

tl = TestRailLibrary('https://gtestbtest01.testrail.io',    'gtestbtest01@gmail.com',    'SwMh7YAiB7u4OB5RKVrY-Y8GPA7IatidpY3/EAjmZ')

pprint(tl._client.password)#
pprint(tl._client.user)

c = TestRailLibrary.get_case(tl,  130)

#pprint(c)

#body = TestRailLibrary.Add_Result_To_Test_Case(tl, 35, 130, 1, comment="test intgr comment", version='v 0.1')

#runs = TestRailLibrary.Get_TestRail_ProjectRuns(tl, 'QTC example')

#runid = TestRailLibrary.Get_TestRail_RunID(tl, 'P1', 'Test Run 5\/8\/2018' )

#planRuns = TestRailLibrary.Get_TestRail_PlanRuns(tl, 'P1', 'Regression')

#rid = TestRailLibrary.Get_TestRail_RunID_by_plan_config(tl, 'P1', 'Regression', 'Test Run 5/8/2018', 'IE')

#r = TestRailLibrary.Add_Result_To_TestRail_Case_Run_Config(tl, 'P1', 'Regression', 'Test Run 5/8/2018', 'IE', '278', 'PASS', comment='failed once IE')
#r = TestRailLibrary.Add_Result_To_TestRail_Case_Run_Config(tl, 'P1', 'Regression', 'Test Run 5/8/2018', 'FF', '278', 'FAIL', comment='failed once FF')
r = TestRailLibrary.Add_Result_To_TestRail_Case_Run_Config(tl, 'P1', 'Regression', 'Run-13',  'IE, es-es', '278', 'PASS', comment='failed twice \n rrr', custom_log_url='http://spb8456:8888/job/TestRail%20Integration%20Pilot%20Project/Browser=IE,Culture=es-es/13/robot/report/log.html#s1-s4-s3-t1')

#p = TestRailLibrary.Create_Test_Run_with_all_cases(tl, 'P1', 'Run 123','Run from Code')


#p = TestRailLibrary.Add_Test_Run_to_Plan_with_all_cases_configs(tl, 'P1', 'Master', 'Regression','Run 123456','Run from Code', ['FF'])


#p = TestRailLibrary.Get_TestRail_RunID_by_plan_configs(tl, 'P1', 'Regression', 'Run-13',  'IE, es-es')
#p = TestRailLibrary.Get_TestRail_RunID_by_plan_configs(tl, 'P1', 'plan2', 'TRinThePlan4',  None)
#p  = TestRailLibrary.Get_TestRail_PlanRuns(tl, 'P1', 'Regression') 

#p = TestRailLibrary.Get_TestRail_configIDs_by_name(tl, 'P1', ['Chrome', 'FF', 'jp'])

#r = tl.Get_TestRail_RunID('QTC example', 'SFDC')

#pprint(r)

#tags = [u'C123', u'ffff']

#cid = tl.Extract_CaseID_From_Robot_Tags(tags)

pprint(r)


