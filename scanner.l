%{
/* LEXICAL ANALYZER (SCANNER) - CST-405 Compiler Project
 * Integrated version for complete compiler pipeline
 *
 * Authors: Christian Nshuti Manzi & Aime Serge Tuyishime
 * Course: CST-405 Compiler Design
 * Project: Complete Compiler Implementation
 *
 * This scanner recognizes tokens for a simple programming language
 * with while loops and relational operators (NEW FEATURE)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"  /* Token definitions from Bison */

/* Global variables for tracking */
int line_num = 1;
int col_num = 1;
int token_count = 0;
int error_count = 0;
int char_count = 0;

/* Function prototypes */
void update_location();
%}

/* Flex options */
%option nounput
%option noinput

/* Pattern definitions */
DIGIT       [0-9]
LETTER      [a-zA-Z]
ID          {LETTER}({LETTER}|{DIGIT}|_)*
NUM         {DIGIT}+
WS          [ \t]

%%

"int"           {
                  update_location();
                  yylval.str = strdup(yytext);
                  return INT;
                }

"print"         {
                  update_location();
                  yylval.str = strdup(yytext);
                  return PRINT;
                }

"while"         {
                  update_location();
                  yylval.str = strdup(yytext);
                  return WHILE;
                }

{ID}            {
                  update_location();
                  yylval.str = strdup(yytext);
                  return ID;
                }

{NUM}           {
                  update_location();
                  yylval.num = atoi(yytext);
                  return NUM;
                }

"+"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return PLUS;
                }

"="             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return ASSIGN;
                }

"<="            {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RELOP;
                }

">="            {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RELOP;
                }

"=="            {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RELOP;
                }

"!="            {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RELOP;
                }

"<"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RELOP;
                }

">"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RELOP;
                }

";"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return SEMICOLON;
                }

"("             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return LPAREN;
                }

")"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RPAREN;
                }

"{"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return LBRACE;
                }

"}"             {
                  update_location();
                  yylval.str = strdup(yytext);
                  return RBRACE;
                }

"//".*          {
                  /* Single-line comment - ignore */
                  update_location();
                }

{WS}+           {
                  col_num += yyleng;
                  char_count += yyleng;
                }

\n              {
                  line_num++;
                  col_num = 1;
                  char_count++;
                }

.               {
                  fprintf(stderr, "LEXICAL ERROR at Line %d, Col %d: Unrecognized character '%c' (ASCII %d)\n",
                          line_num, col_num, *yytext, *yytext);
                  col_num++;
                  char_count++;
                  error_count++;
                }

%%

/* Support function - update location tracking */
void update_location() {
    col_num += yyleng;
    char_count += yyleng;
}

/* Required by flex - indicates end of input */
int yywrap() {
    return 1;
}
