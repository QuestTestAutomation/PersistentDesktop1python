from robot.libraries.BuiltIn import BuiltIn
import copy, datetime, json, pprint

class TestExecutionListener(object):
    ROBOT_LISTENER_API_VERSION = 2
    ROBOT_LIBRARY_SCOPE = "TEST CASE"
   

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self.current_test_attrs = {}
        self.all_keywords_elapsed = 0
        self.tmp_file_name = 'test_result.json'
    
    def _start_test(self, name, attrs):
        self.current_test_attrs = attrs

    def _end_keyword(self, name, attrs):
        self.all_keywords_elapsed = self.all_keywords_elapsed + int(attrs['elapsedtime'])
        

    def Return_Test_Info(self, name):
        return self.current_test_attrs
    