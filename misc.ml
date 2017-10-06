(* CSE 130: Programming Assignment 1
 * misc.ml
 *)


(* Name: Yitzchak Blank
 *  PID: A13069713
 *)



(* sumList : int list -> int 
 *   This function finds the sum of the individual elements of a list by 
 *   recursively adding the first element in the list to the return value 
 *   of the function called recursively on the remainder of the list. 
 *) 

let rec sumList l = match l with 
        | [] -> 0
        | h::t -> h + sumList t;;



(* listReverseHelper : 'a list -> 'a list -> 'a list
 *   This function reverses the elements of a list. It takes in 
 *   the list to be reversed as well as the list to append to, and
 *   calls itself recursively to fill that second list 
 *)

let rec listReverseHelper l j =  match l with
        | [] -> j
        | h::t -> let k = h::j in listReverseHelper t k;; 



(* reverseDigitsOfInt : int -> int list
 *   This function gives the individual digits of an int in a list in reverse
 *   order. The function recursively calls  itself, each time appending the 
 *   smallest number to the front of the list and then cutting down the number 
 *   for the recursive function call
 *)

let rec reverseDigitsOfInt n = match n with 
      | 0 -> []
      | _ -> n mod 10 :: reverseDigitsOfInt (n/10);;



(* digitsOfInt : int -> int list 
 *   Returns the indiviual digits of an integer in a list. It calls 
 *   reverseDigitsofInt to obtain tbe digits in reverse order, and then 
 *   passes that list to listReverseHelper to correct the order.    
 *   (see the digits function below for an example of what is expected)
 *)

let rec digitsOfInt n = 
      let k = reverseDigitsOfInt n 
        in listReverseHelper k [];; 

     

(* digits : int -> int list
 *   (digits n) is the list of digits of n in the order in which they appear
 *   in n
 *   e.g. (digits 31243) is [3,1,2,4,3]
 *      (digits (-23422) is [2,3,4,2,2]
 *)
 
let digits n = digitsOfInt (abs n)


(* From http://mathworld.wolfram.com/AdditivePersistence.html
 * Consider the process of taking a number, adding its digits, 
 * then adding the digits of the number derived from it, etc., 
 * until the remaining number has only one digit. 
 * The number of additions required to obtain a single digit from a number n 
 * is called the additive persistence of n, and the digit obtained is called 
 * the digital root of n.
 * For example, the sequence obtained from the starting number 9876 is (9876, 30, 3), so 
 * 9876 has an additive persistence of 2 and a digital root of 3.
 *)


(* additivePersistenceHelper : int -> int -> int 
 *   Finds the additive persistence of any int greater than 9 by counting the number 
 *   of times the number can be passed to sumList before a number less
 *   than 10 is returned. 
 *)

let rec additivePersistenceHelper n i = let k = sumList (digitsOfInt n)
    in match k/10 with  
    | 0 -> i + 1 
    | _ -> additivePersistenceHelper k (i+1);; 



(* additivePersistence : int -> int
 *   Finds the additive persistence of an int. If the int is less than 10, 
 *   it immediately returns 0. Otherwise, it returns the result of the
 *   additivePersistenceHelper function 
 *)

let rec additivePersistence n =  if n < 10 then 0 else additivePersistenceHelper n 0;; 

    

(* digitalRoot : int -> int 
 *  Finds the digital root of an int by passing a list of the digits to 
 *   the sumList function until a number less than 10 is obtained. 
 *)

let rec digitalRoot n = match n/10 with 
    | 0 -> n
    | _ -> digitalRoot (sumList (digitsOfInt n));;



(* listReverse : 'a list -> 'a list
 *  Reverses the order of elements in a list. Accomplishes this by 
 *  calling the listReverseHelper function. 
 *)

let rec listReverse l = listReverseHelper l []



(* explode : string -> char list 
 * (explode s) is the list of characters in the string s in the order in 
 *   which they appear
 * e.g.  (explode "Hello") is ['H';'e';'l';'l';'o']
 *)

let explode s = 
  let rec _exp i = 
    if i >= String.length s then [] else (s.[i])::(_exp (i+1)) in
  _exp 0


(* palindrome: string -> bool
 *  returns a bool representing whether a string is a palindrome. It does
 *  this by representing the string as a list, creating a reverse list, and
 *  then comparing the two lists.
 *)
let palindrome w = listReverse (explode w) = explode w;; 

(************** Add Testing Code Here ***************)
