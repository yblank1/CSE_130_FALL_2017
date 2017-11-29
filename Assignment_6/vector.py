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
        if isinstance(index, slice):
            return Vector(self.vect_list[index]) 
        return self.vect_list[index]

    
    def __setitem__(self, index, value):
        self.check_index(index, False)
        self.vect_list[index] = value


    def __eq__(self, obj):
        """ Checks whether a vector is equal to another object """
        if not isinstance(obj, Vector):
            return False
        # Check if the lengths of the vectors are the same
        if len(self) != len(obj):
            return False
        # Check for equality component-wise
        for i, j in enumerate(self.vect_list):
            if j != obj[i]:
                return False
        return True
                 

    def __ne__(self, obj):
        """ Checks whether a vector is not equal to another object """
        return not self.__eq__(obj)

    def gt_ge_helper(self, vect, ge = False):
        temp_self_list = list(self.vect_list)
        temp_vect_list = list(vect.vect_list)
        while(1):
            if len(temp_self_list) == 0:
                if ge == False: 
                    return False
                else:
                    return True 
            if max(temp_self_list) > max(temp_vect_list):
                return True
            elif max(temp_self_list) == max(temp_vect_list) and len(temp_self_list) > 0:
                temp_self_list.remove(max(temp_self_list))
                temp_vect_list.remove(max(temp_vect_list))
                continue 
            else:
                return False 

    def __gt__(self, vect):
        """ Checks whether a vector is greater than another. It is defined 
        as the greatest element in the first vector being greater than the 
        greatest element in the second vector. Vectors are assumed to be of 
        the same length.""" 
        return self.gt_ge_helper(vect)

    def __lt__(self, vect):
        """ Checks whether a vector is less than another. It is defined as 
        the greatest element in the first vector being less than the greatest
        element in the second fvector. The argument is assumed to be a vector
        and the vectors are assumed to be of the same length. """
        return vect.__gt__(self) 

 
    def __ge__(self, vect):
        return self.gt_ge_helper(vect, True)   
 
    def __le__(self, vect):
        return vect.__ge__(vect)

"""        if (self < vect) or (self == vect):
            return True 
        return False     
  """
