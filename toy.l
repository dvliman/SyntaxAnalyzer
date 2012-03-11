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


"/*"(([^*]|(("*"+)[^*/]))*)("*"+)"/"\n {; /* multiline comment, skip it */ }
"//"((.)*)\n                           {; /* line comment, skip it */ }

bool        { return (t_bool); } 
break       { return (t_break); }
class       { return (t_class); } 
double      { return (t_double); }
else        { return (t_else); } 
extends     { return (t_extends); } 
for         { return (t_for); } 
if          { return (t_if); }
implements  { return (t_implements); } 
int         { return (t_int); } 
interface   { return (t_interface); } 
newarray    { return (t_newarray); } 
println     { return (t_println); } 
readln      { return (t_readln); }
return      { return (t_return); }
string      { return (t_string); }
void        { return (t_void); } 
while       { return (t_while); }

true|false  { return (t_boolconstant); } 

"+"         { return(t_plus); }
"-"         { return(t_minus); }
"*"         { return(t_multiplication); }
"/"         { return(t_division); }
"<="        { return(t_lessequal); }
">"         { return (t_greater); }
">="        { return(t_greaterequal); }
"=="        { return (t_equal); }
"!="        { return (t_notequal); }
"="         { return (t_assignop); }
";"         { return(t_semicolon); }
","         { return(t_comma); }
"."         { return(t_period); }
"("         { return(t_leftparen); }
")"         { return(t_rightparen); }
"["         { return(t_leftbracket); }
"]"         { return(t_rightbracket); }
"{"         { return(t_leftbrace); }
"}"         { return(t_rightbrace); }

{newline}       { printf("\n"); }
{integer}       { return(t_intconstant); }
{double}        { return(t_doubleconstant); }
{string}        { return(t_stringconstant); }
{identifier}    { return(t_id); }
{ws}            {; /* ignore whitespace */ }
.               {; /* ignore bad characters */ }

%%


