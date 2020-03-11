from TestRailLibrary import TestRailLibrary
import argparse, pprint

def main():
   
    parser = argparse.ArgumentParser(description='Create a Test Run in Test Rails')
    parser.add_argument('-pr', action='store', dest='project', required=True, help='TestRail project')
    parser.add_argument('-su', action='store', dest='test_suite', default = 'Master', help='TestRail test suite. ''Master'' if ommited')
    parser.add_argument('-pl', action='store', dest='test_plan', required=True, help='TestRail test plan')
    parser.add_argument('-tr', action='store', dest='test_run', required=True, help='The name of TestRail test run that will b e created')
    parser.add_argument('-rd', action='store', dest='run_description', default = None, help='TestRail test run dscription')
    #parser.add_argument('-cf', action='append', dest='configs', required=True, help='TestRail configuration. If repeated several times configs will be appended')
    parser.add_argument('-cset', action='append', dest='configset', required=True, help='TestRail configurations set. Contains several congig pairs Browser-Culture')
    parser.add_argument('-us', action='store', dest='tr_user', required=True, help='TestRail user')
    parser.add_argument('-ul', action='store', dest='tr_url', required=True, help='TestRail server URL')
    parser.add_argument('-ak', action='store', dest='tr_key', required=True, help='TestRail API key')
    
    args = parser.parse_args()
    pprint.pprint("")
    pprint.pprint("")
    pprint.pprint("Arguments:")
    pprint.pprint("==========")
    pprint.pprint(args._get_kwargs())
  
    trl = TestRailLibrary(args.tr_url, args.tr_user, args.tr_key)

    result = trl.Add_Test_Run_to_Plan_with_all_cases_configs_set(trl, args.project, args.test_suite, args.test_plan, args.test_run, args.run_description, args.configset)
    
    pprint.pprint("")
    pprint.pprint("")
    pprint.pprint("Result:")
    pprint.pprint("=======")
    pprint.pprint(result)

    #if result.status

if __name__ == "__main__":
    main()