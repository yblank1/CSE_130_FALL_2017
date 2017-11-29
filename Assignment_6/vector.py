from misc import Failure

class Vector(object):

    def __init__(self, arg):
        """ Constructor for Vector
        Takes either an int or long (or a subclass of them and creates an empty
        vector of that length. Also takes a sequence and creates a vector with the
        elements of that sequence. 
        """ 
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


    def __repr__(self):
        """ Returns a string representing elements in vector as a list """
        ret_string = "Vector(["
        if self.length > 0:
            ret_string += str(self.vect_list[0])
          
            for i in range(1, self.length): 
                ret_string += ", " + str(self.vect_list[i])
            
        ret_string += "])"
        return ret_string

   
    def __len__(self):
        """ Function that returns the length of the vector """
        return self.length

    def __iter__(self):
        """ Returns an iterator for the Vector object """ 
        return self.vect_list.__iter__()

    def __add__(self, nextSeq):
        """ This function overloads the + to work component-wise on a vector and
        any other sequence """
        # First check that nextSeq is of the same length - if not raise error
        if len(nextSeq) != len(self):
            raise ValueError ("Error! All arguments for vector addition must be\
                of same length")
        else:
            new_list = []
            for i in self:
                new_list.append(i) 
            for i, j in enumerate(nextSeq):
               new_list[i] += j
            return Vector(new_list)

    def __radd__(self, nextSeq):
        return self.__add__(nextSeq) 

    def __iadd__(self, nextSeq):
        new_list = self.__add__(nextSeq)
        self.vect_list = new_list.vect_list
        return self

    def dot(self, next_seq):
        """ Returns the dot product of the vector and another sequence. Throws\
        a valueError if the lengths don't match or a typeError if it is not a
        sequence"""
        # Check to ensure that next_seq is a sequence

        # Check that the lengths are the same
        if len(self) != len(next_seq):
            raise ValueError ("Error: Dot product lengths must be the same")
        else:
            dp = 0
            next_seq_iter = next_seq.__iter__() 
            for i in self:
                j = next_seq_iter.next()
                dp += (i*j)
            return dp


    def check_index(self, index, error=IndexError, get_only = True):
        if isinstance(index, slice):
            start = index.start
            stop = index.stop
            self.check_index(start, ValueError)
            if get_only == False:
                self.check_index(stop, ValueError) 
        elif index < -len(self) or index > len(self):
            print(index) 
            raise error ("Error: Index out of bounds")
        

    def __getitem__(self, index):
        return self.vect_list[index]

    
    def __setitem__(self, index, value):
        self.check_index(index, False)
        self.vect_list[index] = value
""""
    def __getslice__(self, i, j):
        self.check_index(i)
        self.check_index(j)
  #      return self.vect_list[i:j]
""
    def __setslice__(self, i, j, seq):
        self.check_index(i, ValueError)
        self.check_index(j, ValueError)
        self.vect_list[i:j] = seq
"""
