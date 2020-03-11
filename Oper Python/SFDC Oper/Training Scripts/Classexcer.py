
class Fruit(object):


    def __init__(self):
        print('This is Fruit')

    def nutrition(self):
        print('This is nutrition of fruit')

    def fruit_Shape(self):
        print('This is Shape of Fruit')


class Apple(Fruit):

    def __init__(self):
        Fruit.__init__(self)
        print('This is Apple')

    def nutrition(self):
        super(Apple,self).nutrition()
        print('This is nutrition of Apple')

    def fruit_Shape(self):
        super(Apple, self).fruit_Shape()
        print('This is Shape of Apple')


f = Fruit()
f.nutrition()
f.fruit_Shape()

a = Apple()
a.nutrition()
a.fruit_Shape()
