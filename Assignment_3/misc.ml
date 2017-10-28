(* CSE 130: Programming Assignment 3
 * misc.ml
 *)

(* For this assignment, you may use the following library functions:

   List.map
   List.fold_left
   List.fold_right
   List.split
   List.combine
   List.length
   List.append
   List.rev

   See http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html for
   documentation.
*)



(* Do not change the skeleton code! The point of this assignment is to figure
 * out how the functions can be written this way (using fold). You may only
 * replace the   failwith "to be implemented"   part. *)



(*****************************************************************)
(******************* 1. Warm Up   ********************************)
(*****************************************************************)

(* sqsum -- TODO - add type
This method gives the sum of squares of ints in a list. 
It does so by passing a summing function to fold_left.

Params: xs -> the list of ints to take the sum of squares of
Return value: The sum of the squares of the ints in the list. 
*)
let sqsum xs = 
  let f a x = a+(x*x) in
  let base = 0 in
    List.fold_left f base xs
;;

(* Pipes functions to return a function that combines all of the 
functions. Does this by folding left and applying all the functions 
on eachother
*)
let pipe fs = 
  let f a x = (fun z -> (x (a z)))  in
  let base = (fun y -> y)  in  
    List.fold_left f base fs
;;

(* 
Takes a list of elements, adds a separator in between 
each of hte elements, and then concatenates all those results
*)
let rec sepConcat sep sl = match sl with 
  | [] -> ""
  | h :: t -> 
      let f a x = a^x in
      let base = h in
      let l = List.map (fun x -> sep ^ x) t in
        List.fold_left f base l
;;

(* 
Creates a string representation of the list by using map and then 
using sepComcat to convert to string
*)
let stringOfList f l = 
	let l1 = List.map f l  in 
	"[" ^ sepConcat "; " l1 ^"]";;	

(*****************************************************************)
(******************* 2. Big Numbers ******************************)
(*****************************************************************)

(* 
Clones a given item in a list n times using recursion 
*)
let rec clone x n = match n > 0 with 
	| true-> x :: clone x (n-1) 
	| false ->  []
;; 

(* Given two lists, this function pads the list with the fewer elements
with zeros
*)
let rec padZero l1 l2 = 
	let lengthDiff = (List.length l1) - (List.length l2) in 
	match (lengthDiff > 0) with 
	| true -> (l1, List.append (clone 0 lengthDiff)  l2)
	| false -> (List.append(clone 0 (List.length l2 - List.length l1)) l1, l2) 
;;

(* 
Given a list, removes any zeros at the front 
*)
let rec removeZero l = match l with 
	| [] -> []
	| h::t -> match (h == 0) with 
		| true -> removeZero t
		| false -> l
;;


(* 
Adds two lists, where each list represents an integer (each list element is a 
value representing a single digit in an integer
*) 
let bigAdd l1 l2 = 
  let add (l1, l2) = 
    let f a x = let (carry, currRes) = a in 
	let (comb1, comb2) = x in 
	let sum = (comb1 + comb2 + carry) in
	(sum / 10, (sum mod 10) :: currRes) in 	
    let base = (0, []) in
    let args =  List.rev (List.append [(0, 0)] (List.combine l1 l2) ) in
    let (_, res) = List.fold_left f base args in
      res
  in 
    removeZero (add (padZero l1 l2))
;;


(* 
Given a list representing a number, and an int to multiply it by,  
this function returns a new list representing the product. 
*)
let rec mulByDigit i l = 
  let rec f a i l = match i with 
    | 0 -> a
    | _ -> f (bigAdd a l) (i -1) l
  in f [] i l 
;; 
	
(* 
Multiplies two lists representing integers by eachother
*)
let bigMul l1 l2 = 
  let f a x = let (buf, curr) = a in 
  let newCumul = mulByDigit x l1 in 
  (0, bigAdd curr newCumul) in
  let base = (0, l1) in
  let args = List.rev l2 in
  let (_, res) = List.fold_left f base args in
    res;;
