%{
#include <stdio.h>
#include "icalc.tab.h"

extern int yylval;
int unary_minus = 0;
%}

%x UNARY_MINUS
 
%%
"+"       { return PLUS; }
"-"       { return MINUS; }
"*"       { return MULT; }
"/"       { return DIV; }
"("       { return LPAREN; }
")"       { return RPAREN; }
"="       { return ASSIGN; }
"+="      { return PLUS_ASSIGN; }
"-="      { return MINUS_ASSIGN; }
"*="      { return MULT_ASSIGN; }
"/="      { return DIV_ASSIGN; }
"--"      { return DECREMENT; }
"++"      { return INCREMENT; }
"%"       { return MOD; }
"MAXINT"  { return MAXINT; }
"MININT"  { return MININT; }
"^"       { return POW; }
"abs"     { return ABSOLUTE; }
"min"     { return MIN; }
"max"     { return MAX; }
","       { return COMMA; }
"&&"      { return AND; }
"||"      { return OR; }
"=="      { return EQUAL; }
"!="      { return NOT_EQUAL; }
"<="      { return LESSTHAN_EQUAL; }
">="      { return GREATERTHAN_EQUAL; }
"<"       { return LESSTHAN; }
">"       { return GREATERTHAN;}
"?"       { return QUESTION_MARK; }
":"       { return COLON; }
"exit"    { return EXIT; }


[a-z]     { yylval = *yytext; return REGISTER; }

[0-9]+ {
    yylval = atoi(yytext);
    return NUM;
}

[ \t\f\v]+ { /* ignore white space */ }

[^0-9+\-*/()] { return yytext[0]; }

%%
