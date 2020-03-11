
try:
    d = {'Make':'BMW','Model':'Class A','Year':'2009'}
    print(d)
   # print(d['key'])
    print(d['Make'])
    d['Make'] = 'Ambassdor'
    print(d['Make'])
    print(d)
except:
    print("Attribute key is not defined")
finally:
    print("I am in finally")