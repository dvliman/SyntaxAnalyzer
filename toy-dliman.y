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
Program: Decl {}
  ;

Decl: VariableDecl { $$ = $1; }
  | FunctionDecl   { $$ = $1; }
  | ClassDecl      { $$ = $1; }
  | InterfaceDecl  { $$ = $1; }
  ;

VariableDecl: Variable ';'  { $$ = $1; }
  ;

Variable: t_id  { $$ = $1; }
  ;

FunctionDecl: Type t_id '(' Formals ')' StmtBlock { printf("FunctionDecl"); }
  ;

ClassDecl: t_class Extends Implements '{' Fields '}'  { printf("ClassDecl"); }

Extends: t_extends t_id { $$ = $2; }
  |                     { $$ = NULL; }
  ;

Implements: Implements ',' t_id { $$= $3; }
  | t_implements t_id           { $$ =$2; }
  ;

Fields: Fields VariableDecl { $$ = $2; }
  | Fields FunctionDecl     { $$ = $2; }
  | VariableDecl            { $$ = $1; }
  | FunctionDecl            { $$ = $1; }
  ;

InterfaceDecl: t_interface t_id '{' Prototypes '}' {}
  ;

Prototypes: Prototypes Type t_id '(' Formals ')' ';' {}
  | Type t_id {}
  ; 

Type: t_bool    { $$ = $1; }
  | t_int     { $$ = $1; }
  | t_double  { $$ = $1; }
  | t_string  { $$ = $1; }
  | Type t_leftbracket t_rightbracket { $$ = $1; }
  | t_id      { $$ = $1; }
  ;

Formals: Formals t_comma Variable { $$ = $1; }
  |  Variable                     { $$ = $1; }
  ;

FunctionDecl:

Formals: 

ClassDecl:

Field:

InterfaceDecl:

Prototype:

StmtBlock:

Stmt:

IfStmt:

WhileStmt:

ForStmt: 

BreakStmt: t_break t_semicolon 
  ;

ReturnStmt: t_return Expr
  ;

PrintStmt: t_println Expr
  ; 

Expr: 

Lvalue: t_id          { $$ = $1; }
  | Expr '.' t_id     { $$ = $1 + $3; }
  | Expr '[' Expr ']' { $$ = $1 + $3; }
  ;

Call:

Actuals:

Constant: t_intconstant
  | t_doubleconstant
  | t_stringconstant
  | t_boolconstant
  ;

%%

int main() {
  yyparse();
}
