from misc import Failure

class Vector(object):

    """ Constructor for Vector
        Takes either an int or long (or a subclass of them and creates an empty
        vector of that length. Also takes a sequence and creates a vector with the
        elements of that sequence. """ 
    def __init__(self, arg):
    
    # Case 1: it is of type int, long, or a class derived from those
        if isinstance(arg, (int, long)):
           
            # TODO - print relevant message  
            # If it is negative, raise failure
            if (arg < 0): raise ValueError("Error: int or long passed to vector\
                constructor must be greater than zero")
            
            # Otherwise create a Vector of that length 
            else: 
                self.vect_list = [0.0] * arg
                self.length = arg
    
    # Case 2: arg is of type sequence. Create a 
        elif isinstance(arg, (list, tuple, str, bytearray)):
            self.length = len(arg)
            self.vect_list = []
            for i in arg:
                self.vect_list.append(i) 
    
        elif isinstance(arg, Vector):
            self.length = arg.length 
            self.vect_list = arg.vect_list
        
        # If type is wrong -- ERROR 
        else:
            raise TypeError("int, long, or sequence type must be passed to\
                Vector constructor")


    """ Function to represent elements in vector as a list """
    def __repr__(self):
        ret_string = "Vector(["
        if self.length > 0:
            ret_string += str(self.vect_list[0])
          
            for i in range(1, self.length): 
                ret_string += ", " + str(self.vect_list[i])
            
        ret_string += "])"
        return ret_string

    
