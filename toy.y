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
%left t_or
%left t_and
%right t_equal t_notequal
%nonassoc t_less t_greater t_lessequal t_greaterequal
%left t_plus t_minus
%left t_multiplication t_division

%%
Program: Dec { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  ;

Dec: Dec Decl { $$ = $2; printf("[Reduce %i%s",yyn,"]");}
    | Decl { printf("[Reduce %i%s",yyn,"]");}
    ;

Decl: VariableDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | FunctionDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | ClassDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | InterfaceDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

VariableDecls: VariableDecl VariableDecls { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

VariableDecl: Variable t_semicolon { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

Variable: Type t_id { $$ = $2; printf("[Reduce %i%s",yyn,"]");}
    ;

Type: t_bool    { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | t_int     { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | t_double  { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | t_string  { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | Type t_leftbracket t_rightbracket { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | t_id      { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

FunctionDecl: Type t_id t_leftparen Formals t_rightparen StmtBlock { printf("[Reduce %i%s",yyn,"]");}
    | t_void t_id t_leftparen Formals t_rightparen StmtBlock { printf("[Reduce %i%s",yyn,"]");}
    ;

Formals: Formals t_comma Variable { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | Variable { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

ClassDecl: t_class t_id Extends Implements t_leftbrace Field t_rightbrace { printf("[Reduce %i%s",yyn,"]");} 
    ;

Extends: t_extends t_id { $$ = $2; printf("[Reduce %i%s",yyn,"]");}
    |                     { printf("[Reduce %i%s",yyn,"]");}
    ;

Implements: t_implements IDList { $$= $2; printf("[Reduce %i%s",yyn,"]");}
    |   { printf("[Reduce %i%s",yyn,"]");}
    ;

IDList: t_id t_comma IDList           { $$ =$1; printf("[Reduce %i%s",yyn,"]");}
    |  t_id { $$ =$1; printf("[Reduce %i%s",yyn,"]");}
    ;

Field: VariableDecl { printf("[Reduce %i%s",yyn,"]");} 
    | FunctionDecl { printf("[Reduce %i%s",yyn,"]");}
    |   { printf("[Reduce %i%s",yyn,"]");}
    ;

InterfaceDecl: t_interface t_id t_leftbrace Prototypes t_rightbrace { printf("[Reduce %i%s",yyn,"]");} 
    | t_interface t_id t_leftbrace t_rightbrace { printf("[Reduce %i%s",yyn,"]");}
    ;

Prototypes: Prototype Prototypes { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Prototype: Type t_id t_leftparen Formals t_rightparen t_semicolon { printf("[Reduce %i%s",yyn,"]");} 
    | t_void t_id t_leftparen Formals t_rightparen t_semicolon { printf("[Reduce %i%s",yyn,"]");}
    ;

StmtBlock: t_leftbrace VariableDecls Stmts t_rightbrace { printf("[Reduce %i%s",yyn,"]");} 
    ;

Stmts: Stmts Stmt { printf("[Reduce %i%s",yyn,"]");}
    | Stmt { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Stmt: ExprOrEmpty t_semicolon { printf("[Reduce %i%s",yyn,"]");}
    | IfStmt { printf("[Reduce %i%s",yyn,"]");} 
    | WhileStmt { printf("[Reduce %i%s",yyn,"]");} 
    | ForStmt { printf("[Reduce %i%s",yyn,"]");} 
    | BreakStmt { printf("[Reduce %i%s",yyn,"]");} 
    | ReturnStmt { printf("[Reduce %i%s",yyn,"]");} 
    | PrintStmt { printf("[Reduce %i%s",yyn,"]");} 
    | StmtBlock { printf("[Reduce %i%s",yyn,"]");}
    ;

IfStmt: t_if t_leftparen Expr t_rightparen Stmt { printf("[Reduce %i%s",yyn,"]");} 
    | t_if t_leftparen Expr t_rightparen Stmt t_else Stmt { printf("[Reduce %i%s",yyn,"]");}
    ;

WhileStmt: t_while t_leftparen Expr t_rightparen Stmt
    ;

ForStmt: t_for t_leftparen ExprOrEmpty t_semicolon Expr t_semicolon ExprOrEmpty t_rightparen Stmt { $$ =$3+$5+$7+$9; printf("[Reduce %i%s",yyn,"]");} 
    ;

BreakStmt: t_break t_semicolon 
  ;

ReturnStmt: t_return ExprOrEmpty t_semicolon { printf("[Reduce %i%s",yyn,"]");} 
    ;

PrintStmt: t_println t_leftparen ExprList t_rightparen t_semicolon { printf("[Reduce %i%s",yyn,"]");} 
    ;

ExprList: ExprList t_comma Expr { $$ = $1+$3; printf("[Reduce %i%s",yyn,"]");}
    | Expr { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

ExprOrEmpty: Expr { $$=$1; printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Expr: Lvalue t_assignop Expr { printf("[Reduce %i%s",yyn,"]");} 
    | Constant { printf("[Reduce %i%s",yyn,"]");} 
    | Lvalue { printf("[Reduce %i%s",yyn,"]");} 
    | Call { printf("[Reduce %i%s",yyn,"]");} 
    | t_leftparen Expr t_rightparen { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_plus Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_minus Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_multiplication Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_division Expr { printf("[Reduce %i%s",yyn,"]");}
    | t_minus Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_less Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_lessequal Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_greater Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_greaterequal Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_equal Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr t_notequal Expr { printf("[Reduce %i%s",yyn,"]");}
    | t_readln t_leftparen t_rightparen { printf("[Reduce %i%s",yyn,"]");}
    | t_newarray t_leftparen t_intconstant t_comma Type t_rightparen { printf("[Reduce %i%s",yyn,"]");}
    ;

Lvalue: t_id { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | Expr t_leftbracket Expr t_rightbracket { $$ = $1 + $3; printf("[Reduce %i%s",yyn,"]");}
    | Expr t_period t_id { $$ = $1 + $3; printf("[Reduce %i%s",yyn,"]");}
    ;

Call: t_id t_leftparen Actuals t_rightparen { $$ = $1+$3; printf("[Reduce %i%s",yyn,"]");} 
    | t_id t_period t_id t_leftparen Actuals t_rightparen { $$ = $1+$3+$5; printf("[Reduce %i%s",yyn,"]");}
    ;

Actuals: Expr { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | Expr t_comma Actuals { $$ = $1+$3; printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Constant: t_intconstant { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | t_doubleconstant { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | t_stringconstant { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | t_boolconstant { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  ;

%%

int main() {
  yyparse();
  return 0;
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
