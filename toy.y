/*
// Name: Vallejos, Marcus
// Project: #2
// Due: 3-12-2012
// Course: CS-411
//
// Description:
// A syntactical analyzer for the Toy-based language
*/

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

%right t_assignop
%right t_or
%right t_and
%right t_equal t_notequal
%nonassoc t_less t_greater t_lessequal t_greaterequal
%left t_plus t_minus
%left t_multiplication t_division

%%
Program: Dec { $$ = $1; }
  ;

Dec: Dec Decl { $$ = $2; }
    | Decl { }
    ;

Decl: VariableDecl { $$ = $1; } 
    | FunctionDecl { $$ = $1; } 
    | ClassDecl { $$ = $1; } 
    | InterfaceDecl { $$ = $1; }
    ;

VariableDecls: VariableDecl VariableDecls { }
    | { }
    ;

VariableDecl: Variable t_semicolon { $$ = $1; }
    ;

Variable: Type t_id { $$ = $2; }
    ;

Type: t_bool    { $$ = $1; }
    | t_int     { $$ = $1; }
    | t_double  { $$ = $1; }
    | t_string  { $$ = $1; }
    | Type t_leftbracket t_rightbracket { $$ = $1; }
    | t_id      { $$ = $1; }
    ;

FunctionDecl: Type t_id t_leftparen Formals t_rightparen StmtBlock { }
    | t_void t_id t_leftparen Formals t_rightparen StmtBlock { }
    ;

Formals: Formals t_comma Variable { $$ = $1; } 
    | Variable { }
    | { }
    ;

ClassDecl: t_class t_id Extends Implements t_leftbrace Field t_rightbrace { } 
    ;

Extends: t_extends t_id { $$ = $2; }
    |                     { }
    ;

Implements: t_implements IDList { $$= $2; }
    |   { }
    ;

IDList: t_id t_comma IDList           { $$ =$1; }
    |  t_id { $$ =$1; }
    ;

Field: VariableDecl { } 
    | FunctionDecl { }
    |   { }
    ;

InterfaceDecl: t_interface t_id t_leftbrace Prototypes t_rightbrace { } 
    | t_interface t_id t_leftbrace t_rightbrace { }
    ;

Prototypes: Prototype Prototypes { }
    | { }
    ;

Prototype: Type t_id t_leftparen Formals t_rightparen t_semicolon { } 
    | t_void t_id t_leftparen Formals t_rightparen t_semicolon { }
    ;

StmtBlock: t_leftbrace VariableDecls Stmts t_rightbrace { } 
    ;

Stmts: Stmts Stmt { }
    | { }
    ;

Stmt: ExprOrEmpty t_semicolon { }
    | IfStmt { } 
    | WhileStmt { } 
    | ForStmt { } 
    | BreakStmt { } 
    | ReturnStmt { } 
    | PrintStmt { } 
    | StmtBlock { }
    ;

IfStmt: t_if t_leftparen Expr t_rightparen Stmt { } 
    | t_if t_leftparen Expr t_rightparen Stmt t_else Stmt { }
    ;

WhileStmt: t_while t_leftparen Expr t_rightparen Stmt
    ;

ForStmt: t_for t_leftparen ExprOrEmpty t_semicolon Expr t_semicolon ExprOrEmpty t_rightparen Stmt { } 
    ;

BreakStmt: t_break t_semicolon 
  ;

ReturnStmt: t_return ExprOrEmpty t_semicolon { } 
    ;

PrintStmt: t_println t_leftparen ExprList t_rightparen t_semicolon { } 
    ;

ExprList: ExprList t_comma Expr { $$ = $1+$3; }
    | Expr { $$ = $1; }
    ;

ExprOrEmpty: Expr { $$=$1; }
    | { }
    ;

Expr: Lvalue t_assignop Expr { } 
    | Constant { } 
    | Lvalue { } 
    | Call { } 
    | t_leftparen Expr t_rightparen { }
    | Expr t_plus Expr { }
    | Expr t_minus Expr { }
    | Expr t_multiplication Expr { }
    | Expr t_division Expr { }
    | t_minus Expr { }
    | Expr t_less Expr { }
    | Expr t_lessequal Expr { }
    | Expr t_greater Expr { }
    | Expr t_greaterequal Expr { }
    | Expr t_equal Expr { }
    | Expr t_notequal Expr { }
    | t_readln t_leftparen t_rightparen { }
    | t_newarray t_leftparen t_intconstant t_comma Type t_rightparen { }
    ;

Lvalue: t_id { $$ = $1; }
    | Expr t_leftbracket Expr t_rightbracket { $$ = $1 + $3; }
    | Expr t_period t_id { $$ = $1 + $3; }
    ;

Call: t_id t_leftparen Actuals t_rightparen { $$ = $1+$3; } 
    | t_id t_period t_id t_leftparen Actuals t_rightparen { $$ = $1+$3+$5; }
    ;

Actuals: Expr { $$ = $1; }
    | Expr t_comma Actuals { $$ = $1+$3; }
    | { }
    ;

Constant: t_intconstant { $$ = $1; }
  | t_doubleconstant { $$ = $1; }
  | t_stringconstant { $$ = $1; }
  | t_boolconstant { $$ = $1; }
  ;

%%

int main() {
  yyparse();
}

yyerror(s)
char *s;
{
    printf("yacc error: %s\n", s);
}

yywrap()
{
    return(0);
}
