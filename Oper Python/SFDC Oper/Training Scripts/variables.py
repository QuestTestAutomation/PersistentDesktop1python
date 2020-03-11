"""
table
object reference count
"""

a="nyc"
b="nyc"

print(a)
print(a == a.upper())
print(a == a.lower())
print(a == b)
c = a.upper()
print(c)
a=123

print(a)
print(b)

b=456
print(b)

c='nyc'
d=c

print(c==d)
print(d is c)