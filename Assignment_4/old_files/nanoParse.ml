type token =
  | Num of (int)
  | Id of (string)
  | EOF
  | LET
  | EQ
  | IN
  | FUN
  | PLUS
  | MUL
  | AND
  | OR
  | LPAREN
  | RPAREN
  | SEMI
  | COLONCOLON
  | TRUE
  | FALSE
  | MINUS
  | DIV
  | LT
  | LE
  | NE
  | REC
  | ARROW
  | IF
  | THEN
  | ELSE

open Parsing;;
let _ = parse_error;;
# 2 "nanoParse.mly"
(* See this for a tutorial on ocamlyacc
 * http://plus.kaist.ac.kr/~shoh/ocaml/ocamllex-ocamlyacc/ocamlyacc-tutorial/ *)
open Nano

let rec consAtTheEnd l e = match l with
  | NilExpr       -> Bin (e, Cons, NilExpr)
  | Bin(h, op, t) -> Bin (h, op,   consAtTheEnd t e)
# 41 "nanoParse.ml"
let yytransl_const = [|
    0 (* EOF *);
  259 (* LET *);
  260 (* EQ *);
  261 (* IN *);
  262 (* FUN *);
  263 (* PLUS *);
  264 (* MUL *);
  265 (* AND *);
  266 (* OR *);
  267 (* LPAREN *);
  268 (* RPAREN *);
  269 (* SEMI *);
  270 (* COLONCOLON *);
  271 (* TRUE *);
  272 (* FALSE *);
  273 (* MINUS *);
  274 (* DIV *);
  275 (* LT *);
  276 (* LE *);
  277 (* NE *);
  278 (* REC *);
  279 (* ARROW *);
  280 (* IF *);
  281 (* THEN *);
  282 (* ELSE *);
    0|]

let yytransl_block = [|
  257 (* Num *);
  258 (* Id *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\003\000\003\000\
\004\000\004\000\005\000\005\000\006\000\006\000\007\000\007\000\
\008\000\008\000\009\000\009\000\010\000\010\000\010\000\010\000\
\010\000\011\000\011\000\000\000"

let yylen = "\002\000\
\001\000\006\000\007\000\004\000\006\000\001\000\003\000\001\000\
\003\000\001\000\003\000\001\000\003\000\001\000\003\000\001\000\
\003\000\001\000\002\000\001\000\001\000\001\000\001\000\001\000\
\003\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\021\000\024\000\000\000\000\000\000\000\022\000\
\023\000\000\000\028\000\001\000\000\000\000\000\000\000\012\000\
\000\000\000\000\000\000\020\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\019\000\
\000\000\000\000\000\000\025\000\000\000\000\000\000\000\011\000\
\000\000\013\000\000\000\000\000\000\000\004\000\000\000\000\000\
\000\000\000\000\002\000\000\000\005\000\003\000"

let yydgoto = "\002\000\
\011\000\012\000\013\000\014\000\015\000\016\000\017\000\018\000\
\019\000\020\000\000\000"

let yysindex = "\009\000\
\006\255\000\000\000\000\000\000\254\254\003\255\006\255\000\000\
\000\000\006\255\000\000\000\000\005\255\007\255\015\255\000\000\
\253\254\017\255\012\255\000\000\031\255\034\255\014\255\026\255\
\020\255\012\255\012\255\012\255\012\255\012\255\012\255\000\000\
\006\255\035\255\006\255\000\000\006\255\007\255\015\255\000\000\
\017\255\000\000\012\255\037\255\006\255\000\000\023\255\006\255\
\045\255\006\255\000\000\006\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\018\000\043\000\089\000\000\000\
\081\000\047\000\001\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\107\000\099\000\000\000\
\070\000\000\000\024\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\252\255\000\000\000\000\014\000\025\000\004\000\000\000\022\000\
\023\000\239\255\000\000"

let yytablesize = 389
let yytable = "\021\000\
\018\000\032\000\024\000\029\000\023\000\025\000\003\000\004\000\
\005\000\001\000\030\000\006\000\003\000\004\000\026\000\027\000\
\007\000\006\000\028\000\022\000\008\000\009\000\007\000\017\000\
\031\000\032\000\008\000\009\000\044\000\010\000\046\000\040\000\
\047\000\042\000\033\000\034\000\035\000\036\000\045\000\038\000\
\049\000\048\000\008\000\051\000\037\000\053\000\016\000\054\000\
\050\000\052\000\041\000\039\000\000\000\043\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\015\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\014\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\010\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\009\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\007\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\018\000\018\000\000\000\018\000\
\018\000\018\000\018\000\000\000\018\000\000\000\018\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\006\000\000\000\
\000\000\018\000\018\000\017\000\017\000\006\000\017\000\017\000\
\017\000\017\000\000\000\017\000\000\000\017\000\000\000\000\000\
\000\000\000\000\006\000\006\000\000\000\000\000\000\000\008\000\
\017\000\017\000\016\000\016\000\008\000\016\000\008\000\016\000\
\016\000\000\000\016\000\000\000\016\000\000\000\000\000\000\000\
\000\000\000\000\000\000\008\000\008\000\000\000\000\000\016\000\
\016\000\015\000\015\000\000\000\015\000\000\000\015\000\015\000\
\000\000\015\000\000\000\015\000\014\000\014\000\000\000\000\000\
\000\000\014\000\014\000\000\000\014\000\010\000\015\000\015\000\
\000\000\010\000\010\000\000\000\010\000\000\000\000\000\009\000\
\000\000\014\000\014\000\009\000\009\000\000\000\009\000\007\000\
\000\000\010\000\010\000\000\000\007\000\000\000\007\000\000\000\
\000\000\000\000\000\000\009\000\009\000\000\000\000\000\000\000\
\000\000\000\000\000\000\007\000\007\000"

let yycheck = "\002\001\
\000\000\019\000\007\000\007\001\002\001\010\000\001\001\002\001\
\003\001\001\000\014\001\006\001\001\001\002\001\010\001\009\001\
\011\001\000\000\004\001\022\001\015\001\016\001\011\001\000\000\
\008\001\043\000\015\001\016\001\033\000\024\001\035\000\028\000\
\037\000\030\000\004\001\002\001\023\001\012\001\004\001\026\000\
\045\000\005\001\000\000\048\000\025\001\050\000\000\000\052\000\
\026\001\005\001\029\000\027\000\255\255\031\000\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\000\000\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\004\001\005\001\255\255\007\001\
\008\001\009\001\010\001\255\255\012\001\255\255\014\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\005\001\255\255\
\255\255\025\001\026\001\004\001\005\001\012\001\007\001\008\001\
\009\001\010\001\255\255\012\001\255\255\014\001\255\255\255\255\
\255\255\255\255\025\001\026\001\255\255\255\255\255\255\005\001\
\025\001\026\001\004\001\005\001\010\001\007\001\012\001\009\001\
\010\001\255\255\012\001\255\255\014\001\255\255\255\255\255\255\
\255\255\255\255\255\255\025\001\026\001\255\255\255\255\025\001\
\026\001\004\001\005\001\255\255\007\001\255\255\009\001\010\001\
\255\255\012\001\255\255\014\001\004\001\005\001\255\255\255\255\
\255\255\009\001\010\001\255\255\012\001\005\001\025\001\026\001\
\255\255\009\001\010\001\255\255\012\001\255\255\255\255\005\001\
\255\255\025\001\026\001\009\001\010\001\255\255\012\001\005\001\
\255\255\025\001\026\001\255\255\010\001\255\255\012\001\255\255\
\255\255\255\255\255\255\025\001\026\001\255\255\255\255\255\255\
\255\255\255\255\255\255\025\001\026\001"

let yynames_const = "\
  EOF\000\
  LET\000\
  EQ\000\
  IN\000\
  FUN\000\
  PLUS\000\
  MUL\000\
  AND\000\
  OR\000\
  LPAREN\000\
  RPAREN\000\
  SEMI\000\
  COLONCOLON\000\
  TRUE\000\
  FALSE\000\
  MINUS\000\
  DIV\000\
  LT\000\
  LE\000\
  NE\000\
  REC\000\
  ARROW\000\
  IF\000\
  THEN\000\
  ELSE\000\
  "

let yynames_block = "\
  Num\000\
  Id\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp8) in
    Obj.repr(
# 28 "nanoParse.mly"
                                       ( _1 )
# 265 "nanoParse.ml"
               : Nan,o.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Nan,o.expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Nan,o.expr) in
    Obj.repr(
# 30 "nanoParse.mly"
                                       ( Let(_2,_4,_6) )
# 274 "nanoParse.ml"
               : 'exp8))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : Nan,o.expr) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : Nan,o.expr) in
    Obj.repr(
# 32 "nanoParse.mly"
                                       ( Letrec (_3, _5, _7) )
# 283 "nanoParse.ml"
               : 'exp8))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Nan,o.expr) in
    Obj.repr(
# 33 "nanoParse.mly"
                                       ( Fun (_2, _4) )
# 291 "nanoParse.ml"
               : 'exp8))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Nan,o.expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Nan,o.expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Nan,o.expr) in
    Obj.repr(
# 34 "nanoParse.mly"
                                       ( If (_2, _4, _6) )
# 300 "nanoParse.ml"
               : 'exp8))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp7) in
    Obj.repr(
# 35 "nanoParse.mly"
                                       ( _1 )
# 307 "nanoParse.ml"
               : 'exp8))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'exp7) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp6) in
    Obj.repr(
# 37 "nanoParse.mly"
                                       ( Bin(_1,Or,_3) )
# 315 "nanoParse.ml"
               : 'exp7))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp6) in
    Obj.repr(
# 38 "nanoParse.mly"
                                       ( _1 )
# 322 "nanoParse.ml"
               : 'exp7))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'exp6) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp5) in
    Obj.repr(
# 40 "nanoParse.mly"
                                       ( Bin(_1,And,_3) )
# 330 "nanoParse.ml"
               : 'exp6))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp5) in
    Obj.repr(
# 41 "nanoParse.mly"
                                       ( _1 )
# 337 "nanoParse.ml"
               : 'exp6))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'exp5) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp54) in
    Obj.repr(
# 43 "nanoParse.mly"
                                       ( Bin(_1,Eq,_3) )
# 345 "nanoParse.ml"
               : 'exp5))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp54) in
    Obj.repr(
# 45 "nanoParse.mly"
                                       ( _1 )
# 352 "nanoParse.ml"
               : 'exp5))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'exp4) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp54) in
    Obj.repr(
# 47 "nanoParse.mly"
                                       ( Bin(_1,Cons,_3) )
# 360 "nanoParse.ml"
               : 'exp54))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp4) in
    Obj.repr(
# 48 "nanoParse.mly"
                                       ( _1 )
# 367 "nanoParse.ml"
               : 'exp54))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'exp4) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp3) in
    Obj.repr(
# 50 "nanoParse.mly"
                                       ( Bin(_1,Plus,_3) )
# 375 "nanoParse.ml"
               : 'exp4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp3) in
    Obj.repr(
# 52 "nanoParse.mly"
                                         ( _1 )
# 382 "nanoParse.ml"
               : 'exp4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'exp3) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exp2) in
    Obj.repr(
# 54 "nanoParse.mly"
                                       ( Bin(_1,Mul,_3) )
# 390 "nanoParse.ml"
               : 'exp3))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp2) in
    Obj.repr(
# 56 "nanoParse.mly"
                                       ( _1 )
# 397 "nanoParse.ml"
               : 'exp3))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'exp2) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 58 "nanoParse.mly"
                                       ( App(_1,_2) )
# 405 "nanoParse.ml"
               : 'exp2))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'exp1) in
    Obj.repr(
# 59 "nanoParse.mly"
                                       ( _1 )
# 412 "nanoParse.ml"
               : 'exp2))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 61 "nanoParse.mly"
                                       ( Const _1 )
# 419 "nanoParse.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "nanoParse.mly"
                                       ( True )
# 425 "nanoParse.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "nanoParse.mly"
                                       ( False )
# 431 "nanoParse.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "nanoParse.mly"
                                       ( Var(_1) )
# 438 "nanoParse.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Nan,o.expr) in
    Obj.repr(
# 67 "nanoParse.mly"
                                       ( _2 )
# 445 "nanoParse.ml"
               : 'exp1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Nan,o.expr) in
    Obj.repr(
# 69 "nanoParse.mly"
                                       ( consAtTheEnd NilExpr _1 )
# 452 "nanoParse.ml"
               : 'expseq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expseq) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Nan,o.expr) in
    Obj.repr(
# 70 "nanoParse.mly"
                                       ( consAtTheEnd _1      _3 )
# 460 "nanoParse.ml"
               : 'expseq))
(* Entry exp *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let exp (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Nan,o.expr)
