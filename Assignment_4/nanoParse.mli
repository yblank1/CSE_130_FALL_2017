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
  | REC
  | ARROW
  | IF
  | THEN
  | ELSE

val exp :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Nano.expr
