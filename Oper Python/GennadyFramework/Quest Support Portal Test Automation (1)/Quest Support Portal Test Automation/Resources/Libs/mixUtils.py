import pyodbc
import json
import collections
import pprint
import urllib
import md5
import re
import logging
from random import randint

def date_handler(obj):
    return obj.isoformat() if hasattr(obj, 'isoformat') else obj


def query_result_to_json(connectionString, query, fields_dict, returnList=1, num_set=0):
    """
    Returns result of query as json.
    Parameter fields_dict is dictionary of fields' names and numbers of json.
        
    Example:
    | Query Result To Json | Driver={SQL Server};Server=serverName;Database=dbName;Uid=user;Pwd=pwd; | select top 5 uid, dname from qb_product | [ID=0,NAME=1] |
    """
	
    j = ''

    fields = dict(fields_dict)
	
    conn = pyodbc.connect(connectionString)
    cursor = conn.cursor()
 
    cursor.execute(query)

    rows = cursor.fetchall()

    if num_set > 0 :
        for i in range(num_set) :
            if cursor.nextset() :
                if i==num_set-1 : rows = cursor.fetchall()
            else : break
    
    d = collections.OrderedDict()
    
    objects_list = []
    for row in rows:
        for k, v in fields.items():
            if isinstance(v, int):
                d[k]=row[v]
            else:
                d[k]=v
        if returnList!=1:
                break
        objects_list.append(d)
        d = collections.OrderedDict()
 
    if returnList==1:
        j = json.dumps(objects_list, default=date_handler)
    else:
        j = json.dumps(d, default=date_handler)

    cursor.commit()
 
    conn.close()
	
    return j


def ordered(obj):
    if isinstance(obj, dict):
        return sorted((k, ordered(v)) for k, v in obj.items())
    if isinstance(obj, list):
        return sorted(ordered(x) for x in obj)
    else:
        return obj


def compare_json(str1, str2):
    """
    """
    if isinstance(str1, str):
        json1 = json.loads(str1)
    else:
        json1 = str1
    if isinstance(str2, str):
        json2 = json.loads(str2)
    else:
        json2 = str2
        
    return ordered(json1)==ordered(json2)


def diff_json(obj1, obj2, path_item=''):
    diff = []
    if isinstance(obj1, dict) and isinstance(obj2, dict):
        for k, v in obj1.items():
            if k in obj2.keys():
                returnDiff = diff_json(v, obj2[k], path_item+'\\'+k)
                for i in range(len(returnDiff)):
                    diff.append(returnDiff[i])
            else:
                diff.append('item %s with value %s not in second json' % (k, v))
        for k, v in obj2.items():
            if k not in obj1.keys():
                diff.append('item %s with value %s not in first json' % (k, v))
    elif isinstance(obj1, list) and isinstance(obj2, list):
        if obj1 != obj2:
            for x in obj1:
                if obj2.count(x) == 0:
                    diff.append('value of list %s of item %s doesn`t contain in second json' % (x, path_item))
                elif obj1.count(x) != obj2.count(x):
                    diff.append('the number of values %s in the list of item %s are different: %s | %s' % (x, path_item, obj1.count(x), obj2.count(x)))
            for x in obj2:
                if x not in obj1:
                    diff.append('value of list %s of item %s doesn`t contain in first json' % (x, path_item))               
    else:
        if obj1 != obj2:
            diff.append('values for item %s not equal in jsons: %s | %s' % (path_item, obj1, obj2))
    return diff

def difference_json(obj1, obj2):
    if isinstance(obj1, str):
        json1 = json.loads(obj1)
    else:
        json1 = obj1
    if isinstance(obj2, str):
        json2 = json.loads(obj2)
    else:
        json2 = obj2
    res = diff_json(ordered(json1),ordered(json2))
    if res!=[]:
        pprint.pprint('Difference json:')
        pprint.pprint(res, indent=4)  
    return res


def update_value_json(parent_json, field, embed_json):
    """
    """
    if isinstance(parent_json, str):
        json1 = json.loads(parent_json)
    else:
        json1 = parent_json

    if isinstance(embed_json, str):
        value1 = json.loads(embed_json)
    else:
        value1 = embed_json

    if json1.has_key(field):
        json1[field] = value1

    j = json.dumps(json1)
        
    return j

def is_json(val):
    if isinstance(val, str):
        try:
            json_object = json.loads(val)
        except ValueError, e:
            return False
        return True
    else:
        return False

def Get_SCVarialbles_Dict(val):
    #if isinstance(val, str):
        try:
            #val = urllib.unquote(vals_list[1]).decode('utf8')

            val_l = len(val)

            val = val[val.rfind("?") + 1 :]

            val = val[:-3]
                                   
            string_list = val.split("&amp;")

            dc = dict()

            for i in string_list:
                vals_list = i.split("=")
                dc.update({vals_list[0]: urllib.unquote(vals_list[1]).decode('utf8')})

            return dc

        except ValueError, e:
            return "non dct"
    #else:
       # return "non str"

def keep_in_dictionary_if_key_matches(dictionary, *keys_re):
    
    keep_keys = []
     
    for key, value in dictionary.items():
        for key_pattern in keys_re:
            pattern = re.compile(key_pattern)
            if pattern.match(key):
                keep_keys.append(key)
    
    for key, value in dictionary.items():
        if key not in keep_keys:
            dictionary.pop(key)
       

def Calculate_MD5 (val):
    m = md5.new()
    m.update(val)
    return m.hexdigest()

def Fetch_byID_TempMail (val, mail_id):
    emails = json.loads(val)
    if 'error' not in emails:
        for e in emails:
            if e['mail_id'] == mail_id:
                return e
    else:
        return dict()

def convert_email_to_GMail(val, email_addr=''):
    GMail = dict()

    if 'error' not in val:
        mail_from = val['mail_from'].lower()
        mail_from = re.search("^.*<(.*)>.*", mail_from).group(1)
        #mail_from = mail_from.replace('>', '')
        GMail['mail_id'] = val['mail_id']
        GMail['mail_from'] = mail_from
        GMail['mail_recipient'] = email_addr
        GMail['mail_subject'] = val['mail_subject']
        GMail['mail_excerpt'] = ""
        GMail['mail_body'] = val['mail_text']
        GMail['mail_timestamp'] = val['mail_timestamp']

        return GMail
    else:
        return dict()    

def convert_collection_to_GM(tempMails):
    GMmailList = list()
    
    for tempMail in tempMails:
        GMail = convert_email_to_GMail(tempMail)
        GMmailList.append(GMail)
    return GMmailList

def Get_Latest_Mail(GMails):
    count = len(GMails)
    if count == 0: 
        return dict()
    else:    
        return GMails[count-1]

def Get_weekday_name():
    from datetime import date
    import calendar
    my_date = date.today()
    return calendar.day_name[my_date.weekday()]

def Get_week_part():
    d = Get_weekday_name()
    if d in ('Saturday', 'Sunday'):
        return 'Weekend'
    else:
        return 'Weekday' 

def print_dictionary(dictionary, custom_description=""):
    if (custom_description != ""):
        print custom_description
        print "---------------------------------------"
    print "{:<10} | {:<24}".format('Variable','Value')
    print "---------------------------------------"
    for k, v in dictionary.iteritems():
        print "{:<10} | {:<24}".format(k, v)