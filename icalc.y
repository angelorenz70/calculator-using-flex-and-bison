%{

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <ctype.h>
#include "icalc.tab.h"

int registers[26];

const int MAX_INT = 2147483647;
const int MIN_INT = -2147483648;

int resultPow(int base, int power) {
    double result = pow(base, power);
    if (result > MAX_INT) {
        return MAX_INT;
    }
    if (result < MIN_INT) {
        return MIN_INT;
    }
    return (int)result;
}

int absolute(int abs_){
    return abs(abs_);
}

int max_number(int op1, int op2){
    int result = op1;
    if(result < op2){
        result = op2;
    }
    return result;
}

int min_number(int op1, int op2){
    int result = op1;
    if(result > op2){
        result = op2;
    }
    return result;
}

int yylex(); // Declare the lexer function
%}

%token LPAREN RPAREN
%token NUM MAXINT MININT
%token REGISTER INCREMENT DECREMENT 
%token PLUS MINUS MULT DIV MOD
%right POW
%right MINUS_UNARY
%left ABSOLUTE
%left MAX MIN COMMA

%left PLUS MINUS
%left MULT DIV MOD
%right ASSIGN
%right PLUS_ASSIGN MINUS_ASSIGN MULT_ASSIGN DIV_ASSIGN


%start repl

%%  /* begin grammar rules section */

repl:  /* empty */ { printf("icalc: "); }
     | repl input '\n'
     | repl error '\n' { yyerrok; printf("icalc: "); }
     ;

input: expr { printf("%d\nicalc: ", $1); }
     ;

expr:   MINUS_UNARY expr { $$ = -$2; } 
     | expr PLUS expr { $$ = $1 + $3; }
     | expr MINUS expr { $$ = $1 - $3; }
     | expr MULT expr { $$ = $1 * $3; }
     | expr DIV expr { $$ = $1 / $3; }
     | expr MOD expr { $$ = $1 % $3; }
     | expr POW expr { $$ = resultPow($1, $3); }
     | ABSOLUTE LPAREN expr_list RPAREN { $$ = absolute($3); }
     | MAX LPAREN expr COMMA expr RPAREN { $$ = max_number($3, $5); }
     | MIN LPAREN expr COMMA expr RPAREN { $$ = min_number($3, $5); }
     | LPAREN expr_list RPAREN { $$ = $2; }
     | NUM { $$ = $1; }
     | register
     ;

expr_list: expr { $$ = $1; }
     | expr_list COMMA expr { $$ = $3}
     ;

register: REGISTER { $$ = registers[$1 - 'a']; }
     | REGISTER ASSIGN expr { $$ = registers[$1 - 'a'] = $3; }
     | REGISTER PLUS_ASSIGN expr { $$ = registers[$1 - 'a'] += $3; }
     | REGISTER MINUS_ASSIGN expr { $$ = registers[$1 - 'a'] -= $3; }
     | REGISTER MULT_ASSIGN expr { $$ = registers[$1 - 'a'] *= $3; }
     | REGISTER DIV_ASSIGN expr { $$ = registers[$1 - 'a'] /= $3; }
     | REGISTER DECREMENT { $$ = registers[$2 - 'a']--; } //post
     | REGISTER INCREMENT { $$ = registers[$2 - 'a']++; } //post
     | DECREMENT REGISTER { $$ = --registers[$1 - 'a']; } //pre
     | INCREMENT REGISTER { $$ = ++registers[$1 - 'a']; } //pre
     | MININT { $$ = MIN_INT; }
     | MAXINT { $$ = MAX_INT; }
     ;

%%

int yyerror (char* msg) { fprintf(stderr, "%s\n", msg); }
int yywrap () 		{ fprintf(stderr, "exiting...\n"); return (1); }

int main () 
{ 
    yyparse();  /* call the start rule to begin parsing and evaluating exprs */
}

