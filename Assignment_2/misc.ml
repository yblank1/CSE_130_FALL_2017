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
let removeDuplicates l = 
  let rec helper (seen,rest) = 
      match rest with 
        [] -> seen
      | h::t -> 
        let seen' = failwith "to be written" in
        let rest' = failwith "to be written" in 
	  helper (seen',rest') 
  in
      List.rev (helper ([],l))


(* Small hint: see how ffor is implemented below *)
let rec wwhile (f,b) = failwith "to be written"

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
