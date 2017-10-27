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
let pipe fs = 
  let f a x = (fun z -> (x (a z)))  in
  let base = (fun y -> y)  in  
    List.fold_left f base fs
;;

let rec sepConcat sep sl = match sl with 
  | [] -> ""
  | h :: t -> 
      let f a x = a^x in
      let base = h in
      let l = List.map (fun x -> sep ^ x) t in
        List.fold_left f base l
;;
let stringOfList f l = 
	let l1 = List.map f l  in 
	"[" ^ sepConcat "; " l1 ^"]";;	

(*****************************************************************)
(******************* 2. Big Numbers ******************************)
(*****************************************************************)

let rec clone x n = match n > 0 with 
	| true-> x :: clone x (n-1) 
	| false ->  []
;; 


let rec padZero l1 l2 = 
	let lengthDiff = (List.length l1) - (List.length l2) in 
	match (lengthDiff > 0) with 
	| true -> (l1, List.append (clone 0 lengthDiff)  l2)
	| false -> (List.append(clone 0 (List.length l2 - List.length l1)) l1, l2) 
;;


let rec removeZero l = match l with 
	| [] -> []
	| h::t -> match (h == 0) with 
		| true -> removeZero t
		| false -> l
;;


(* TODO remove List.hd - this is not allowed *)
let bigAdd l1 l2 = 
  let add (l1, l2) = 
    let f a x = let (carry, currRes) = a in 
	let (comb1, comb2) = x in 
	let sum = (comb1 + comb2 + carry) in
	(sum / 10, (sum mod 10) :: currRes) in 	
    let base = (0, []) in
    let args =  List.rev (List.append [(0, 0)] (List.combine l1 l2)) in
    let (_, res) = List.fold_left f base args in
      res
  in 
    removeZero (add (padZero l1 l2))
;;


let rec mulByDigit i l = failwith "to be implemented"

let bigMul l1 l2 = 
  let f a x = failwith "to be implemented" in
  let base = failwith "to be implemented" in
  let args = failwith "to be implemented" in
  let (_, res) = List.fold_left f base args in
    res
