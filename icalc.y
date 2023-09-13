/* iCalc.y - YACC grammar file for a simple cmd-line integer calculator.
 *
 * See the corresponding calc.l file for the specification of the tokens.
 *
 * See Makefile.bison or Makefile.yacc to build the icalc executable using
 * flex/bison or lex/yacc.
 *
 * Originally written by Dr. Lavender
 */

%{
/* put C definitions here that are needed for the actions
 * associated with the grammar rules.
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <ctype.h>
#include "icalc.tab.h"

float registers[53];

int yylex(); // Declare the lexer function
%}

/* define the tokens returned by the lexer specified in icalc.l */

%token LPAREN RPAREN LBRACKET RBRACKET
%token NUM
%token REGISTER

%left MINUS PLUS
%left MULT DIV
%left POST_DECREMENT POST_INCREMENT
%right PRE_DECREMENT PRE_INCREMENT
%right ASSIGN
%right PLUS_ASSIGN MINUS_ASSIGN MULT_ASSIGN DIV_ASSIGN

/* the grammar "start" symbol */

%start repl

%%  /* begin grammar rules section */

/* grammar rules have the form

   rule:  alt-1 { alt-1 actions }
        | alt-2 { alt-2 actions }
	| ...  ...
        | alt-n { alt-n actions }
        ;

 $$n vars are POSITIONAL variables that can be used
 in actions to obtain the value associated with the
 result of evaluating a rule. So if a rule is of the form
 
 expr:   expr PLUS term   { $$ = $1 + $3; }

 The rule expr can be thought of as a procedure that
 'invokes the rhs of the rule, which when evaluated
 the action $$ = $1 + $3  is like executing
 return val(expr) + val(term)

 */

/* repl is the start symbol which yyparse (see below) "calls" to 
 * start the execution of the parser, but it doesn't parse anything,
 * it just issues a prompt (the Read part of the REPL) and then transfers 
 * control to the 'input' rule which EVALualtes an expression, Prints the
 * answer, and issues another prompt (the LOOP) until EOF is reached.
 */

repl:  /* empty */  { printf("icalc: "); }
         | repl input '\n'
         | repl error '\n' { yyerrok; printf("icalc: "); }
         ;

input:   expr { printf("%d\nicalc: ", $1); }
         ;


expr: 
      expr PLUS expr 		{ $$ = $1 + $3; }
	| expr MINUS expr 		{ $$ = $1 - $3; }
     | expr MULT expr 		{ $$ = $1 * $3; }
     | expr DIV expr 		{ $$ = $1 / $3; }
	| LPAREN expr RPAREN           { $$ = $2; }
	| NUM 				{ $$ = $1; } 	
     | register 
     ;

register:  REGISTER { $$ = registers[$1 - 'a']; }
     | REGISTER ASSIGN expr { $$ = registers[$1 - 'a'] = $3; }
     | REGISTER PLUS_ASSIGN expr { $$ = registers[$1 - 'a'] += $3;  }
     | REGISTER MINUS_ASSIGN expr { $$ = registers[$1 - 'a'] -= $3; }
     | REGISTER MULT_ASSIGN expr { $$ = registers[$1 - 'a'] *= $3; }
     | REGISTER DIV_ASSIGN expr { $$ = registers[$1 - 'a'] /= $3; }
     | POST_DECREMENT { $$ = registers[$1 - 'a']--; }
     | POST_INCREMENT { $$ = registers[$1 - 'a']++; }
     | PRE_DECREMENT { $$ = --registers[$1 - 'a']; }
     | PRE_INCREMENT { $$ = ++registers[$1 - 'a']; }
     ;


%% /* end grammar rules */

/* yacc helper functions:
 *
 * yyerror - called by yyparse when a parser error is encountered
 *
 * yywrap - called by yyparse when end-of-file is reached. 
 * It must return a non-zero value to cause yyparse to exit.
 */

int yyerror (char* msg) { fprintf(stderr, "%s\n", msg); }
int yywrap () 		{ fprintf(stderr, "exiting...\n"); return (1); }

/* main function that invokes the generated parser by calling yyparse. 
 * yyparse is a Yacc function that that automatically calls  the
 * lexical analyzer generated by Lex to fetch tokens for the parser.
 */

int main () 
{ 
    printf("Welcome to iCalc 1.0. Copyright 2010. Use <ctrl-d> to exit.\n");

    /* call the yacc generated parser entry point for this grammar */

    yyparse();  /* call the start rule to begin parsing and evaluating exprs */
}

