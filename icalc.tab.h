
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     EXIT = 258,
     LPAREN = 259,
     RPAREN = 260,
     NUM = 261,
     MAXINT = 262,
     MININT = 263,
     REGISTER = 264,
     INCREMENT = 265,
     DECREMENT = 266,
     PLUS = 267,
     MINUS = 268,
     MULT = 269,
     DIV = 270,
     MOD = 271,
     POW = 272,
     MINUS_UNARY = 273,
     ASSIGN = 274,
     DIV_ASSIGN = 275,
     MULT_ASSIGN = 276,
     MINUS_ASSIGN = 277,
     PLUS_ASSIGN = 278,
     COLON = 279,
     QUESTION_MARK = 280,
     ABSOLUTE = 281,
     COMMA = 282,
     MIN = 283,
     MAX = 284,
     OR = 285,
     AND = 286,
     NOT_EQUAL = 287,
     EQUAL = 288,
     LESSTHAN_EQUAL = 289,
     GREATERTHAN_EQUAL = 290,
     LESSTHAN = 291,
     GREATERTHAN = 292
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


