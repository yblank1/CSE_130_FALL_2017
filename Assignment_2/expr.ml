(*
 * expr.ml
 * cse130
 * based on code by Chris Stone
 *)

(* Please do not modify the names or types of any of the following
 * type constructors, or predefined functions, unless EXPLICITLY
 * asked to. You will loose points if you do.
 *)


(* REMEMBER TO DOCUMENT ALL FUNCTIONS THAT YOU WRITE OR COMPLETE *)

type expr = 
    VarX
  | VarY
  | Sine     of expr
  | Cosine   of expr
  | Average  of expr * expr
  | Times    of expr * expr
  | Thresh   of expr * expr * expr * expr	
  | Sine_Norm of expr * expr * expr
  | Cos_Sqrt of expr

(* 
This function takes type expression and returns a sting representation of it. 
it does this by identifying an individual part of the expressioon in each
iteration and then calling itself to determine the remaining parts of the
expression .

Params:     e - the expression to be represented as a string. 

*)

let rec exprToString e = 
	match e with 
	| VarX 			  -> "x"
	| VarY 			  -> "y"
	| Sine e 		  -> "sin(pi*" ^ exprToString e ^ ")" 
	| Cosine e 		  -> "cos(pi*" ^ exprToString e ^ ")" 
	| Average (e1, e2) 	  -> "((" ^ exprToString e1 ^ "+" ^ exprToString e2 ^ ")/2)" 
	| Times (e1, e2) 	  -> exprToString e1 ^ "*" ^ exprToString e2 
	| Thresh (e1, e2, e3, e4) -> "(" ^ exprToString e1 ^ "<" ^ exprToString e2 ^ "?" ^ exprToString e3 ^ ":" ^ exprToString e4 ^ ")"
    | Sine_Norm  (e1, e2, e3) -> "sin(pi*norm(" ^ exprToString e1 ^","^exprToString e2 ^ "," ^ exprToString e3 ^ "))" 
    | Cos_Sqrt  e1      -> "cos(pi*sqrt(" ^ exprToString e1 ^ "))";;	

(* build functions:
     Use these helper functions to generate elements of the expr
     datatype rather than using the constructors directly.  This
     provides a little more modularity in the design of your program *)

let buildX()                       = VarX
let buildY()                       = VarY
let buildSine(e)                   = Sine(e)
let buildCosine(e)                 = Cosine(e)
let buildAverage(e1,e2)            = Average(e1,e2)
let buildTimes(e1,e2)              = Times(e1,e2)
let buildThresh(a,b,a_less,b_less) = Thresh(a,b,a_less,b_less)


let pi = 4.0 *. atan 1.0


(* 
Evaluates an expression of type expr. 
It does this by using the math modules from ocaml, and calling itself
recursively to solve lower layers of the equation. Each layer takes the
evaluation of the lower layers and adds it's evaluation before returning the
expression back. 

paramss:    e - the expreession to be evaluated
            x - the float value for any VarX components of the expression
            y - the flaot value for any VarY components of the expression

*)
 
let rec eval (e,x,y) = 
	match e with
	| VarX 			  -> x
	| VarY			  -> y 
	| Sine e 		  -> sin(pi *. (eval (e, x, y)))   
	| Cosine e 		  -> cos(pi *. (eval (e, x, y)))
	| Average (e1, e2)	  -> ((eval(e1,x,y)+. eval(e2,x,y))/.2.0 ) 
	| Times (e1, e2)	  -> ((eval (e1,x,y)) *. (eval (e2,x,y)))
	| Thresh (e1, e2, e3, e4) -> if (eval (e1,x,y)) < (eval (e2,x,y)) then (eval (e3,x,y)) else (eval (e4,x,y))
    | Sine_Norm (e1, e2, e3)  ->  (sin(pi *. sqrt((eval (e1, x, y) ** 2 +. eval (e2, x,
y) ** 2+. eval (e3, x, y) **2))))
    | Cos_Sqrt (e1)   -> eval Cosine(sqrt(eval (e1, x, y))) 
;;	 

(* (eval_fn e (x,y)) evaluates the expression e at the point (x,y) and then
 * verifies that the result is between -1 and 1.  If it is, the result is returned.  
 * Otherwise, an exception is raised.
 *)
let eval_fn e (x,y) = 
  let rv = eval (e,x,y) in
  assert (-1.0 <= rv && rv <= 1.0);
  rv

let sampleExpr =
      buildCosine(buildSine(buildTimes(buildCosine(buildAverage(buildCosine(
      buildX()),buildTimes(buildCosine (buildCosine (buildAverage
      (buildTimes (buildY(),buildY()),buildCosine (buildX())))),
      buildCosine (buildTimes (buildSine (buildCosine
      (buildY())),buildAverage (buildSine (buildX()), buildTimes
      (buildX(),buildX()))))))),buildY())))

let sampleExpr2 =
  buildThresh(buildX(),buildY(),buildSine(buildX()),buildCosine(buildY()))


(************** Add Testing Code Here ***************)
