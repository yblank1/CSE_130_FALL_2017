(* CSE 130: Programming Assignment 2
 * misc.ml
 *)

(* ***** DOCUMENT ALL FUNCTIONS YOU WRITE OR COMPLETE ***** *)

(* TODO - HEADER 
Basic Info 
Params: d - default int returned if the value is not found
      	k - the value to search for within the list
	l - the list containing sets (ki, vi). If k is found, then return it's 
	    vi. Else return d
IMPORTANT - MUST USE TAIL RECURSION 
I THINK THIS IS TAIL RECURSION BUT MUST TEST FURTHER -- TODO TODO TODO
*)
let rec assoc (d,k,l) = match l with 
	| [] -> d
	| (a,b)::t when a=k -> b
	| h::t -> assoc (d,k,t);;


(* fill in the code wherever it says : failwith "to be written" *)

(* 
TODO -- Proper header 
Parameter - l is the list which will have duplicates removed from

within the helper function
seen is going to hold the list that will remain - ie there are no duplicates
rest is obviously the rest of the list that has not yet been processed

IDEA:
Reverse the list. For each head of the list, run List.mem between h and t. If
true, then discard a. Otherwise, append it to rest. Once done, reverse the seen
list to recover original order... Note the last part is already done...  


This works but seems inefficient. I added the first 3 List.rev calls. Should 
rethink the logic here... Otherwise it works pending further testing --- TODO 
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


(* Small hint: see how ffor is implemented below *)
let rec wwhile (f,b) = match f b with 
	| (b', true) -> wwhile (f,b')
	| (b', false) -> b' ;;	


(* fill in the code wherever it says : failwith "to be written" *)
let fixpoint (f,b) = wwhile ((failwith "to be written"),b)


(* ffor: int * int * (int -> unit) -> unit
   Applies the function f to all the integers between low and high
   inclusive; the results get thrown away.
 *)

let rec ffor (low,high,f) = 
  if low>high 
  then () 
  else let _ = f low in ffor (low+1,high,f)
      
(************** Add Testing Code Here ***************)
