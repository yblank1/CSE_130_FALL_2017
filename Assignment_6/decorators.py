from misc import Failure

class profiled(object):
    def __init__(self,f):
        self.__count=0
        self.__f=f
        self.__name__=f.__name__
    def __call__(self,*args,**dargs):
        self.__count+=1
        return self.__f(*args,**dargs)
    def count(self):
        return self.__count
    def reset(self):
        self.__count=0

class traced(object):
    """ A decorator class that traces the function calls of a 
        recursive function. It prints the arguments used each 
        time as well as all the return values"""
    
    nested_level = 0
    def __init__(self,f):
        """ Constructor for the decorator class"""
        # replace this and fill in the rest of the class
        self.__name__=f.__name__
        self.__f = f
        #self.nested_level = 0
    
    def __call__(self, *args, **dargs):
        """ Runs upon call of decorated function. Handles 
            all the string building to print trace log"""
        str_trace = "" 
        self.args_written = False 
        # Print the bars  
        #for i in range(self.nested_level):
        for i in range(traced.nested_level): 
            str_trace += "| "
        traced.nested_level += 1 
        str_trace += ",- "
        str_trace += (self.__name__ + "(")
        
        if len(args) > 0:
            self.args_written = True
            str_trace += str(args[0])
        for i in args[1:]:
            str_trace += (", " + str(i)) 
        
        # Now deal with **dargs
        if self.args_written and len(dargs) > 0:
            str_trace += ", "
        self.dargs_vals = dargs.items()
        
        if self.args_written == True and len(self.dargs_vals) > 0:
            str_trace += ", "
        
        if len(self.dargs_vals) > 0:     
            i, j = self.dargs_vals[0]
            str_trace += (str(i) + "=" + str(j)) 
     
        for i, j in self.dargs_vals[1:]:
            str_trace += (", " + str(i) + "=" + str(j)) 
     
        str_trace += ")"
        print(str_trace) 
        
        # Print the return value
        
        try: 
            ret_val = self.__f(*args, **dargs)
        except Exception as e:
            traced.nested_level -= 1
            raise e 
        #self.nested_level -= 1
        traced.nested_level -= 1 
        str_trace = "" 
        for i in range(traced.nested_level):
            str_trace += "| "
        str_trace += "`- " 
        str_trace += repr(ret_val)
        print(str_trace)
        return ret_val



class memoized(object):
    def __init__(self,f):
        self.__name__=f.__name__
        self.args_dict = {}
        self.__f = f
    
    def __call__(self, *args, **dargs):

        # If the arg was already found - return or raise immeidately
        args_set = str(args) + str(dargs) 
        if args_set in self.args_dict:
            j = self.args_dict[args_set]
            if isinstance(j, Exception):
                raise j
            return j
   
        # If not already found then :: 
        # Save the result - whehter it returns regularly or
        # raises an exception
        try: 
            result = self.__f(*args, **dargs) 
        except Exception as e:
            result = e
 
        # If the dictionary has never seen either 
        self.args_dict[args_set] = result
        
        # Return the value or raise the exception        
        if isinstance(result, Exception):
            raise result
 
        return result  


# run some examples.  The output from this is in decorators.out
def run_examples():
    for f,a in [(fib_t,(7,)),
                (fib_mt,(7,)),
                (fib_tm,(7,)),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (fib_mp.reset,()),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (even_t,(6,)),
                (quicksort_t,([5,8,100,45,3,89,22,78,121,2,78],)),
                (quicksort_mt,([5,8,100,45,3,89,22,78,121,2,78],)),
                (quicksort_mt,([5,8,100,45,3,89,22,78,121,2,78],)),
                (change_t,([9,7,5],44)),
                (change_mt,([9,7,5],44)),
                (change_mt,([9,7,5],44)),
                ]:
        print "RUNNING %s(%s):" % (f.__name__,", ".join([repr(x) for x in a]))
        rv=f(*a)
        print "RETURNED %s" % repr(rv)

@traced
def fib_t(x):
    if x<=1:
        return 1
    else:
        return fib_t(x-1)+fib_t(x-2)

@traced
@memoized
def fib_mt(x):
    if x<=1:
        return 1
    else:
        return fib_mt(x-1)+fib_mt(x-2)

@memoized
@traced
def fib_tm(x):
    if x<=1:
        return 1
    else:
        return fib_tm(x-1)+fib_tm(x-2)

@profiled
@memoized
def fib_mp(x):
    if x<=1:
        return 1
    else:
        return fib_mp(x-1)+fib_mp(x-2)

@traced
def even_t(x):
    if x==0:
        return True
    else:
        return odd_t(x-1)

@traced
def odd_t(x):
    if x==0:
        return False
    else:
        return even_t(x-1)

@traced
def quicksort_t(l):
    if len(l)<=1:
        return l
    pivot=l[0]
    left=quicksort_t([x for x in l[1:] if x<pivot])
    right=quicksort_t([x for x in l[1:] if x>=pivot])
    return left+l[0:1]+right

@traced
@memoized
def quicksort_mt(l):
    if len(l)<=1:
        return l
    pivot=l[0]
    left=quicksort_mt([x for x in l[1:] if x<pivot])
    right=quicksort_mt([x for x in l[1:] if x>=pivot])
    return left+l[0:1]+right

class ChangeException(Exception):
    pass

@traced
def change_t(l,a):
    if a==0:
        return []
    elif len(l)==0:
        raise ChangeException()
    elif l[0]>a:
        return change_t(l[1:],a)
    else:
        try:
            return [l[0]]+change_t(l,a-l[0])
        except ChangeException:
            return change_t(l[1:],a)

@traced
@memoized
def change_mt(l,a):
    if a==0:
        return []
    elif len(l)==0:
        raise ChangeException()
    elif l[0]>a:
        return change_mt(l[1:],a)
    else:
        try:
            return [l[0]]+change_mt(l,a-l[0])
        except ChangeException:
            return change_mt(l[1:],a)


