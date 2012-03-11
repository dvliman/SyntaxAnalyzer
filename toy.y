%{
#include <stdio.h>
%}

%token t_bool
%token t_break
%token t_class
%token t_double
%token t_else
%token t_extends
%token t_for
%token t_if
%token t_implements
%token t_int
%token t_interface
%token t_newarray
%token t_println
%token t_readln
%token t_return
%token t_string
%token t_void
%token t_while
%token t_plus
%token t_minus
%token t_multiplication
%token t_division
%token t_mod
%token t_less
%token t_lessequal
%token t_greater
%token t_greaterequal
%token t_equal
%token t_notequal
%token t_assignop
%token t_semicolon
%token t_comma
%token t_period
%token t_leftparen
%token t_rightparen
%token t_leftbracket
%token t_rightbracket
%token t_leftbrace
%token t_rightbrace
%token t_boolconstant
%token t_intconstant
%token t_doubleconstant
%token t_stringconstant
%token t_id

%%
Program: exp '\n' {}
  ;



BreakStmt: t_break t_semicolon 
  ;

ReturnStmt: t_return Expr
  ;

PrintStmt: t_println Expr
  ; 

Type: t_void { $$ = 't_void' }
  | t_bool   { }
// TODO: Lvalue = Expr | Constant | Lvalue | Call | ( Expr ) |  
//        readln() | newarray(intconstant, Type)    
Expr: Expr t_plus Expr          { $$ = $1 + $3 }
  | Expr t_minus Expr           { $$ = $1 - $3 }
  | Expr t_multiplication Expr  { $$ = $1 * $3 }
  | Expr t_division Expr        { $$ = $1 / $3 }
  | Expr t_mod Expr             { $$ = $1 % $3 }
  | Expr t_less Expr            { $$ = $1 < $3 }
  | Expr t_lessequal Expr       { $$ = $1 <= $3 }
  | Expr t_greater Expr         { $$ = $1 > $3 }
  | Expr t_greaterequal Expr    { $$ = $1 >= $3 }
  | Expr t_equal Expr           { $$ = $1 == $3 }
  | Expr t_notequal Expr        { $$ = $1 != $3 }
  | Expr t_assignop Expr        { $1 = $3 }
  ;

Lvalue: t_id 
  | Expr t_leftbracket Expr t_rightbracket
  ; // TODO, Define: Expr t_dot id ..... I don't have t_dot

Constant: t_intconstant
  | t_doubleconstant
  | t_stringconstant
  | t_boolconstant
  ;

%%

int main() {
  yyparse();
}