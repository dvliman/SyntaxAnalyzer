/*
// Name: Vallejos, Marcus
// Project: #1
// Due: 3-12-2012
// Course: CS-411
//
// Description:
// A lexical analyzer using a trie-based table
*/

%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h> 
  
  #include "y.tab.h"
  extern int yylval;
%}

hex         (0x|0X)[0-9A-Fa-f]*+
letter      [a-zA-Z]
digit       [0-9]
newline     [\n]
ws          [ \t]+
string      \"[^"\n]*\"
exponent    ((E|e)("+"|"-")?({digit}+))
float1      {digit}+"."{digit}+{exponent}?
float2      {digit}+{exponent}
double      ({float1}|{float2})
integer     {hex}|{digit}+
identifier  {letter}({letter}|{digit}|"_")*   
%%

\/\/.*$ ;   //Skip single-line comment
\/\*[A-Za-z0-9=_\+\-\*\\\/\%\<\{\}\(\)\[\]\!\.\;\,\ \t\n\r\#]*\*\/ ;    //Skip multi-line comment

bool        { printf("\n%s ", yytext); return (t_bool); } 
break       { printf("\n%s ", yytext); return (t_break); }
class       { printf("\n%s ", yytext); return (t_class); } 
double      { printf("\n%s ", yytext); return (t_double); }
else        { printf("\n%s ", yytext); return (t_else); } 
extends     { printf("\n%s ", yytext); return (t_extends); } 
for         { printf("\n%s ", yytext); return (t_for); } 
if          { printf("\n%s ", yytext); return (t_if); }
implements  { printf("\n%s ", yytext); return (t_implements); } 
int         { printf("\n%s ", yytext); return (t_int); } 
interface   { printf("\n%s ", yytext); return (t_interface); } 
newarray    { printf("\n%s ", yytext); return (t_newarray); } 
println     { printf("\n%s ", yytext); return (t_println); } 
readln      { printf("\n%s ", yytext); return (t_readln); }
return      { printf("\n%s ", yytext); return (t_return); }
string      { printf("\n%s ", yytext); return (t_string); }
void        { printf("\n%s ", yytext); return (t_void); } 
while       { printf("\n%s ", yytext); return (t_while); }

true|false  { printf("\n%s ", yytext); return (t_boolconstant); } 

"+"         { printf("\n%s ", yytext); return(t_plus); }
"-"         { printf("\n%s ", yytext); return(t_minus); }
"*"         { printf("\n%s ", yytext); return(t_multiplication); }
"/"         { printf("\n%s ", yytext); return(t_division); }
"<="        { printf("\n%s ", yytext); return(t_lessequal); }
">"         { printf("\n%s ", yytext); return (t_greater); }
">="        { printf("\n%s ", yytext); return(t_greaterequal); }
"=="        { printf("\n%s ", yytext); return (t_equal); }
"!="        { printf("\n%s ", yytext); return (t_notequal); }
"="         { printf("\n%s ", yytext); return (t_assignop); }
";"         { printf("\n%s ", yytext); return(t_semicolon); }
","         { printf("\n%s ", yytext); return(t_comma); }
"."         { printf("\n%s ", yytext); return(t_period); }
"("         { printf("\n%s ", yytext); return(t_leftparen); }
")"         { printf("\n%s ", yytext); return(t_rightparen); }
"["         { printf("\n%s ", yytext); return(t_leftbracket); }
"]"         { printf("\n%s ", yytext); return(t_rightbracket); }
"{"         { printf("\n%s ", yytext); return(t_leftbrace); }
"}"         { printf("\n%s ", yytext); return(t_rightbrace); }

{newline}       { printf("\n"); }
{integer}       { printf("\n%s ", yytext); return(t_intconstant); }
{double}        { printf("\n%s ", yytext); return(t_doubleconstant); }
{string}        { printf("\n%s ", yytext); return(t_stringconstant); }
{identifier}    { printf("\n%s ", yytext); return(t_id); }
{ws}            {; /* ignore whitespace */ }
.               {; /* ignore bad characters */ }

%%