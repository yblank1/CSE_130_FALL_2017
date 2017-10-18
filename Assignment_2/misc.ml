(* CSE 130: Programming Assignment 2
 * misc.ml
 *)

(* Yitzchak Blank
 PID: A13069713
*)
 
(* ***** DOCUMENT ALL FUNCTIONS YOU WRITE OR COMPLETE ***** *)

(*  
This function finds whether a value is present in a list of tuples, where 
each of the tuples contains an index and an associated value. If the index
being searched for is found, the associated value is returned. Otherwise, a 
default return value d is returned. This is implemented using tail recursion 
where if the value is not found at the front of the list, the function 
calls  itself recursively, passing in the remainder of the list.  

Params: d - default int returned if the value is not found
      	k - the value to search for within the list
	    l - the list containing sets (ki, vi). If k is found, then return it's 
	    vi. Else return d
*)
let rec assoc (d,k,l) = match l with 
	| [] -> d
	| (a,b)::t when a=k -> b
	| h::t -> assoc (d,k,t);;



(* 
This function removes duplicates within a list, while keeping the list in the
same order. It does this by reversing the list and using tail recursion to 
continuously pass in the remainder of the list as well as the part of the 
list that has no duplicatess. 

Params:     l - the list who's duplicates are being removed. 
*)

let removeDuplicates l = 
  let rec helper (seen,rest) = 
      match List.rev(rest) with 
        [] -> List.rev(seen)
      | h::t -> 
        let seen' = if List.mem h t then seen else h::seen in
        let rest' = t in 
	  helper (seen',List.rev(rest')) 
  in
      List.rev (helper ([],l))



(*
Runs a function on a parameter b continuously, where the function returns a
tuple containing a bool and the result of the function. If the bool is true, 
wwhile runs the function again with the output from the last time it was run. 
Otherwise, it returns false. 

This was implemented using tail recursion, where if the function is run again
it is simply passed again with the new input into the wwhile function itself. 
If the function is not to be run again, wwhile returns the result imnediately 
with no further calculation.

Params:     f - the function being run. It must return in the form bool * a'
            b - the paramter for f
 
*)
let rec wwhile (f,b) = match f b with 
	| (b', true) -> wwhile (f,b')
	| (b', false) -> b' ;;	




(* 
This function repeatedly takes a function and argument as a paramter and 
repeatedly runs the function on the parameter until the output is equal to the
most recent input, and then returns that most recent input/output. 

It does this by nodifying the input function to return a tuple b' * bool, where
the bool represents whether the input is not equal to the output. This new
function is then passed to wwhile.

Params:     f - the function being run. 
            b - the parameter for f 
*)
let fixpoint (f,b) = 
	let new_func f' b' = let a' = f' b' in 
		(a', a'!= b') in 
		wwhile (new_func f, b);;


(* ffor: int * int * (int -> unit) -> unit
   Applies the function f to all the integers between low and high
   inclusive; the results get thrown away.
 *)

let rec ffor (low,high,f) = 
  if low>high 
  then () 
  else let _ = f low in ffor (low+1,high,f)
      
(************** Add Testing Code Here ***************)
