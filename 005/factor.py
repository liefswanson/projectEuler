class Factor(object):

    def __init__(self, value):
        self.value = value
        self.count = 1

    def __str__(self):
        return str(self.value) + " * " + str(self.count)
        
    def add(self):
        self.count += 1

    def remove(self):
        self.count += 1
