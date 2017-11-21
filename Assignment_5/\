
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
    """Take a string as input and return a list of the string in its original
        and reversed form."""
    ret = []
    str_len = len(str) - 1
    rev_string = "" 
    for i in range(str_len, -1, -1):
        rev_string = rev_string + str[i] 
    ret.append(str)
    ret.append(rev_string) 
    return ret

def transform_capitalize(str):
    """ Take a string as input and return a list of all possible capitalizations
        of the string"""
    if len(str) > 0:
        upper_forms = [(str[0].upper() + i) for i in transform_capitalize(str[1:])]
        lower_forms = [(str[0].lower() + i) for i in transform_capitalize(str[1:])]
        return  list(set(upper_forms + lower_forms)) 
    else:
        return [""]

def transform_digits(str):
    """ Take a string and return a list of all possible digit replacements
        of the string"""
    if len(str) > 0:
        rest = transform_digits(str[1:]) 
        if str[0].lower() == 'o':
            return list(set(["0" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 'z':
            return list(set(["2" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 'a':
            return list(set(["4" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 'b':
            return list(set(["6" + i for i in rest] + ["8" + i for i in rest] + [str[0] +
i for i in rest]))
        elif str[0].lower() == 'i' or str[0].lower == 'l':
            return list(set(["1" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 'e':
            return list(set(["3" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 's': 
            return list(set(["5" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 't': 
            return list(set(["7" + i for i in rest] + [str[0] + i for i in
rest]))
        elif str[0].lower() == 'g' or str[0].lower() == 'q':
            return list(set(["9" + i for i in rest] + [str[0] + i for i in
rest])) 
        else:
            return list(set([str[0] + i for i in rest]))
    else:
        return [""] 
    
 
def check_pass(plain,enc):
    """Check to see if the plaintext plain encrypts to the encrypted
       text enc"""
    salt = enc[:2]
    code = enc[2:]
    if enc == crypt.crypt(plain, salt):
        return True
    else:
        return False  

def load_passwd(filename):
    """Load the password file filename and returns a list of
       dictionaries with fields "account", "password", "UID", "GID",
       "GECOS", "directory", and "shell", each mapping to the
       corresponding field of the file."""
    f = open(filename)
    list_of_pass_dicts = [] 
    for l in f:
        l_split = l.split(":")
        d = {"account": l_split[0], "password": l_split[1], "UID":l_split[2],
"GID":l_split[3], "GECOS":l_split[4], "directory":l_split[5],
"shell":l_split[6]} 
        list_of_pass_dicts.append(d)
    return list_of_pass_dicts 


def crack_pass_file(pass_filename,words_filename,out_filename):
    """Crack as many passwords in file fn_pass as possible using words
       in the file words"""
    d1 = load_passwd(pass_filename)
    f2 = open(words_filename)
    f3 = open(out_filename, "w")
    words = [] 
    poss_passwords = ['']
    poss_caps = [''] 
    poss_reverse = [''] 
    poss_digits = [''] 
    poss_rev_dig = [''] 
    poss_rev_caps = ['']
    poss_digs_caps = ['']
    poss_rev_digs_caps = [''] 
    j = 0
   
     
    known_passwords = []
    for word in f2:
        word = word.rstrip()
        if (len(word) > 5 and len(word) < 9):
            poss_passwords.append(word)
   
    # unencrypted possibilites 
    for password in d1:
        for word in poss_passwords:
            if check_pass(word, password["password"]):
                f3.write(password['account'] + "=" + word + "\n")
                f3.flush() 
                known_passwords.append(password) 
                break

    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []
    
    # Reversed possibilites    
    for word in poss_passwords:
        temp = transform_reverse(word)
        poss_reverse.append(temp[1]) 
    for password in d1:
        for word in poss_reverse:
            if check_pass(word, password["password"]):
                f3.write(password['account'] + "=" + word + "\n")
                f3.flush()
                known_passwords.append(password) 
                break 

    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []


    # Digitized possibilities
    for word in poss_passwords:
        temp = transform_digits(word)
        poss_digits += temp
    for pw in d1:
        for word in poss_digits:
            if check_pass(word, pw["password"]):
                f3.write(pw['account'] + "=" + word + "\n")
                f3.flush() 
                known_passwords.append(pw) 
                break

    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []

    # Reversed and Digitized Possibilities
    for word in poss_digits:
        temp = transform_reverse(word)
        poss_rev_dig.append(temp[1])
    for pw in d1:
        for word in poss_rev_dig:     
            if check_pass(word, pw["password"]):
                f3.write(pw['account'] + "=" + word + "\n")
                f3.flush() 
                known_passwords.append(pw)     
                break
    
    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []

    # Capitalized Possibilities
    for word in poss_passwords:
        temp = transform_capitalize(word)
        for pw in d1:
            for wd in temp:
                if check_pass(wd, pw["password"]):
                    f3.write(pw['account'] + "=" + wd + "\n")
                    f3.flush()
                    known_passwords.append(pw)     
                    break
        poss_caps += temp

    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []


    # Reversed Capitalized
    for word in poss_caps:
        temp = transform_reverse(word)[1]
        for pw in d1:
            if check_pass(temp, pw["password"]):
                f3.write(pw['account'] + "=" + wd + "\n")
                f3.flush()
                known_passwords.append(pw)     
                break
        poss_rev_caps += temp
   
    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []
    
     
    # Digitized Capitalized
    for word in poss_caps:
        temp = transform_digits(word)
        for pw in d1:
            if check_pass(temp, pw["password"]):
                f3.write(pw['account'] + "=" + wd + "\n")
                f3.flush()
                known_passwords.append(pw)     
                break
        poss_digs_caps += temp

    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []


    # Digitized Capitalized and Reversed
    for word in poss_digs_caps:
        temp = transform_reverse(word)
        for pw in d1:
            if check_pass(temp, pw["password"]):
                f3.write(pw['account'] + "=" + wd + "\n")
                f3.flush()
                known_passwords.append(pw)     
                break
        poss_revs_digs_caps += temp

    for pw in known_passwords:
        d1.remove(pw)
    known_passwords = []
                
