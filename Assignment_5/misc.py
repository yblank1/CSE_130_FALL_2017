#PA 4

import re

"Miscellaneous functions to practice Python"

class Failure(Exception):
    """Failure exception"""
    def __init__(self,value):
        self.value=value
    def __str__(self):
        return repr(self.value)

# Problem 1

# data type functions

def closest_to(l,v):
    """Return the element of the list l closest in value to v.  In the case of
       a tie, the first such element is returned.  If l is empty, None is returned."""
    val, diff = l[0], abs(l[0] - v) 
    for elem in l[1:]:
        if abs(elem - v) < diff:
            diff = abs(elem - v)
            val = elem
    return val
 
def make_dict(keys,values):
    """Return a dictionary pairing corresponding keys to values."""
    dictRet = {}
    for key,value in zip(keys,values):
        dictRet[key] = value  
    return dictRet
 
# file IO functions
def word_count(fn):
    """Open the file fn and return a dictionary mapping words to the number
       of times they occur in the file.  A word is defined as a sequence of
       alphanumeric characters and _.  All spaces and punctuation are ignored.
       Words are returned in lower case"""
    word_count_dict = {} 
    fileObj = open(fn, 'r')
    for line in fileObj:
        line = re.sub("\W", " ", line) 
        print(line) 
        words = line.split(" ")
        for word in words:
            if word == " ":    
                continue
            if word in word_count_dict:
                word_count_dict[word] += 1 
            else :
                word_count_dict[word] = 1
      
    return word_count_dict




