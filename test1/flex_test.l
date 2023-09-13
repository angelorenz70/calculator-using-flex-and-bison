%option noyywrap
%{
#include<stdio.h>
}%

INTEGER [0-9]+

%% 

{INTEGER} {
    printf("it's a number\n");
}
\n {return 0;}
. {}


%%

yywrap(){}

int main(){
    yylex();
    return 0;
}