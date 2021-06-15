%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	int store[60];
%}

/* bison declarations */

%token NUM VAR IF ENDIF ELSE ENDELSE MAIN ENDMAIN INT ENDINT FLOAT ENDFLOAT CHAR ENDCHAR DOUBLE ENDDOUBLE START END EQUAL ADD SUB MULT DIV MOD POW LESS GREATER FOR ENDFOR COUNT ENDCOUNT CONDITION ENDCONDITION PRINT ENDPRINT ROOT ENDROOT SIN ENDSIN COS ENDCOS TAN ENDTAN FIB ENDFIB


%left LESS GREATER
%left SUB ADD
%left MULT DIV

/* Grammar rules and actions  */

%%

program: MAIN  cstatement ENDMAIN
	 ;

cstatement: /* NULL */

	| cstatement statement
	;

statement: ';'			
	| declaration ';'		{ printf("Variables have been declared"); }

	| expression ';' 		{ $$=$1; }
	
	| VAR EQUAL expression ';' { 
							store[$1] = $3; 
							printf("Value of the variable: %d\t\n",$3);
							$$=$3;
						}
	| FOR COUNT expression ENDCOUNT statement ENDFOR {
									int i;
									printf("FOR LOOP has started\n");
									for(i=0;i<$3;i++){
										
										printf("Loop Position : %d and value : %d\n", i, $5);
									}
								}
   
	| CONDITION expression ENDCONDITION IF statement ENDIF{
								if($2){
									printf("Value inside if block %d\n",$5);
								}
							}
	| CONDITION expression ENDCONDITION IF statement ENDIF ELSE statement ENDELSE{
								if($2){
									printf("Value inside if block : %d\n",$5);
								}
								else {
									printf("Value inside else block : %d\n", $8);
								}
							}
	| PRINT expression ENDPRINT { printf("The print output : %d\n", $2) ; }

	| FIB expression ENDFIB {
					int i, n, t1 = 0, t2 = 1;
    				int nextTerm = t1 + t2;
    				n = $2;
    				printf("Fibonacci Series: %d, %d, ", t1, t2);

    				for (i = 1; i <= n; ++i) {
        				printf("%d, ", nextTerm);
        				t1 = t2;
        				t2 = nextTerm;
        				nextTerm = t1 + t2;
    				}
		}
	;

	
declaration : TYPE MULTIVAR ENDTYPE  
             ;


TYPE : INT   
     | FLOAT  
     | CHAR
     | DOUBLE 
     ;

ENDTYPE: ENDINT
	 | ENDFLOAT
	 | ENDCHAR
	 | ENDDOUBLE
	 ;



MULTIVAR : MULTIVAR ',' VAR  
    | VAR  
    ;

expression: NUM					{ $$ = $1; 	}

	| VAR						{ $$ = store[$1]; }
	
	| expression ADD expression	{ $$ = $1 + $3; }

	| expression SUB expression	{ $$ = $1 - $3; }

	| expression MULT expression { $$ = $1 * $3; }

	| expression DIV expression	{ if($3){
				     					$$ = $1 / $3;
				  					}
				  					else{
										$$ = 0;
										printf("Division By Zero is not allowed\n");
				  					} 	
				    			}
	| expression MOD expression	{ if($3){
				     					$$ = $1 % $3;
				  					}
				  					else{
										$$ = $1;
										printf("Mod by Zero is not allowed\t");
				  					} 	
				    			}
	| expression POW expression		{ $$ = pow($1 , $3);}
	| expression LESS expression	{ $$ = $1 < $3; }
	
	| expression GREATER expression	{ $$ = $1 > $3; }

	| ROOT expression ENDROOT { $$ = sqrt($2); printf("The ROOT is %lf\n",sqrt($2));}
	| SIN expression ENDSIN { $$ = sin($2*3.1416/180); printf("The value of sine operation : %lf \n", sin($2*3.1416/180)) ; }
	| COS expression ENDCOS { $$ = cos($2*3.1416/180); printf("The value of sine operation : %lf \n", cos($2*3.1416/180)) ; }
	| TAN expression ENDTAN { $$ = tan($2*3.1416/180); printf("The value of sine operation : %lf \n", tan($2*3.1416/180)) ; }

	;
%%


yyerror(char *s){
	printf( "%s\n", s);
}

