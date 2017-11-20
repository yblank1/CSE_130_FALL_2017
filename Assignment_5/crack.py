
from misc import *
import crypt
import re

def load_words(filename,regexp):
    """Load the words from the file filename that match the regular
       expression regexp.  Returns a list of matching words in the order
       they are in the file."""
    f = open(filename)
    matching_words = []
    for word in f:
        if re.match(regexp, word.strip()):
            matching_words.append(word.strip())
    return matching_words

def transform_reverse(str):
    ret = []
    str_len = len(str) - 1
    rev_string = "" 
    for i in range(str_len, -1, -1):
        rev_string = rev_string + str[i] 
    ret.append(str)
    ret.append(rev_string) 
    return ret

def transform_capitalize(str):
    if len(str) > 0:
        upper_forms = [(str[0].upper() + i) for i in transform_capitalize(str[1:])]
        lower_forms = [(str[0].lower() + i) for i in transform_capitalize(str[1:])]
        return  upper_forms + lower_forms 
    else:
        return [""]

def transform_digits(str):
    raise Failure("to be written")

def check_pass(plain,enc):
    """Check to see if the plaintext plain encrypts to the encrypted
       text enc"""
    raise Failure("to be written")

def load_passwd(filename):
    """Load the password file filename and returns a list of
       dictionaries with fields "account", "password", "UID", "GID",
       "GECOS", "directory", and "shell", each mapping to the
       corresponding field of the file."""
    raise Failure("to be written")

def crack_pass_file(pass_filename,words_filename,out_filename):
    """Crack as many passwords in file fn_pass as possible using words
       in the file words"""
    raise Failure("to be written")

