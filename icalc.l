%{
#include <stdio.h>
#include "icalc.tab.h"

extern int yylval;
int unary_minus = 0;
%}

%x UNARY_MINUS

%%
"+"       { return PLUS; }
"-"       { 
            if (unary_minus) {
                unary_minus = 0;
                return MINUS_UNARY;
            } else {
                unary_minus = 1;
                BEGIN(UNARY_MINUS);
            }
          }
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

[a-z]     { yylval = *yytext; return REGISTER; }

<UNARY_MINUS>[0-9]+ {
    yylval = -atoi(yytext);
    unary_minus = 0;
    BEGIN(INITIAL);
    return NUM;
}

<UNARY_MINUS>[(] {
    yylval = MINUS_UNARY;
    unary_minus = 0;
    BEGIN(INITIAL);
    return MINUS_UNARY;
}

[0-9]+ {
    yylval = atoi(yytext);
    return NUM;
}

[ \t\f\v]+ { /* ignore white space */ }

[^0-9+\-*/()] { return yytext[0]; }
