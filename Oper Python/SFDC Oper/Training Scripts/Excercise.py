

def cal_tax(State='NY',income=1000):

    if State == 'NY':
        stax = 5
    elif State == 'NJ':
        stax = 4
    elif State == 'IL':
        stax = 6
    else :
        stax = 10

    return (income - (income * (stax/100))  - (income * 0.1))

print("The net salasy is : " + str(cal_tax('NY',20000)))
print(cal_tax('NJ',30000))