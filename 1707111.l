%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include<math.h>
	#include "1707111.tab.h"
%}

ALPHA [a-zA-Z]
DIGIT [0-9]
IMPORT			"<import>"[ ]*[a-zA-Z.<>]+[ ]*"<\/import>"
SCOMMENT		"<comment>"[a-zA-Z0-9,.\\?!@#$%^&*()-{}+_=<>\|'";\t ]*"\n"
MCOMMENT		"<comment>"[a-zA-Z0-9,.\\?!@#$%^&*()-{}+_=<>\|'";\t\n ]*"</comment>"

%%

{DIGIT}+	{ yylval = atoi(yytext); return NUM; }
{ALPHA}	    { yylval = *yytext - 'a'; return VAR; }


"<for>" 		{ return FOR;}
"</for>"		{ return ENDFOR;}
"<count>"	    { return COUNT;}
"</count>"		{ return ENDCOUNT;}

"<print>"		{return PRINT;}
"</print>"		{return ENDPRINT;}
"<root>"		{ return ROOT;}
"</root>"		{ return ENDROOT;}


{SCOMMENT}		{}
{MCOMMENT}		{}
{IMPORT}  		{}
[@<>,():;]     {yylval = yytext[0];	return *yytext;	}


"<condition>"	{ return CONDITION;}
"</condition>"	{ return ENDCONDITION;}
"<true>"			{ return IF;}
"</true>"			{ return ENDIF;}
"<false>"		{ return ELSE;}
"</false>"		{ return ENDELSE;}

"<sin>"			{ return SIN;}
"</sin>"		{ return ENDSIN;}
"<cos>"			{ return COS;}
"</cos>"		{ return ENDCOS;}
"<tan>"			{ return TAN;}
"</tan>"		{ return ENDTAN;}
"<fibonacci>"	{ return FIB;}
"</fibonacci>"	{ return ENDFIB;}


"<add>"			{return ADD;}
"<sub>"			{return SUB;}
"<multi>"		{return MULT;}
"<div>"			{return DIV;}
"<mod>"			{return MOD;}
"<pow>"			{return POW;}
"<less>"		{return LESS;}
"<greater>"		{return GREATER;}
"<equal>"		{return EQUAL;}

"<int>"  		{return INT;}
"</int>"  		{return ENDINT;}
"<char>"        {return CHAR;}
"</char>"        {return ENDCHAR;}
"<float>" 	    {return FLOAT;}
"</float>" 	    {return ENDFLOAT;}
"<double>"		{return DOUBLE;}
"</double>"		{return ENDDOUBLE;}

"<main>"	    { return MAIN; }
"</main>"		{return ENDMAIN;}
[ ]*	    	{}
[\n]*			{}
[\t]*			{}
.				{printf("%s is invalid input\n",yytext);}

%%

int yywrap()
{
	return 1;
}

int main()
{
	freopen("input.txt","r",stdin);
	freopen("output.txt","w",stdout);
	yyparse();
    
	return 0;
}