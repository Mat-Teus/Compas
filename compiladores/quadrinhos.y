%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int yyerror(const char *s);
int yylex(void);
int errorc = 0;

typedef struct{
	char *nome;
	int token;
}simbolo;

int simbolo_qtd = 0;
simbolo tsimbolos[100];
simbolo *simbolo_novo(char *nome, int token);
bool simbolo_existe(char *nome);
void debug();

%}

%define parse.error verbose

%union {
    char *nome;
}

%token COMECA TERMINA
%token MAIN FIM_MAIN
%token FUNCAO FIM_FUNCAO
%token PRINT IF ELSE WHILE FOR POR PAGINAS VAR CHAMA ONOMATOPEIA
%token INT FLOAT DOUBLE CHAR
%token CODIGO_COMECO CODIGO_FIM
%token NUMBER
%token IDENT 
%left '+' '-'
%left '*' '/'

%type <nome> IDENT

%%

programa:
      COMECA declaracoes TERMINA
;

declaracoes:
      /* vazio */
    | declaracoes declaracao
;

declaracao:
      main
    | funcao
;

main:
      MAIN CODIGO_COMECO comandos CODIGO_FIM FIM_MAIN
;

funcao:
      FUNCAO IDENT CODIGO_COMECO comandos CODIGO_FIM FIM_FUNCAO
;

comandos:
      /* vazio */
    | comandos comando
;

comando:
      PRINT '"' IDENT '"'  ONOMATOPEIA
    | VAR tipo IDENT ONOMATOPEIA
    | VAR tipo IDENT '=' expressao ONOMATOPEIA
    | IDENT '=' expressao ONOMATOPEIA
    | IF '(' expressao ')' CODIGO_COMECO comandos CODIGO_FIM
    | IF '(' expressao ')' CODIGO_COMECO comandos CODIGO_FIM ELSE CODIGO_COMECO comandos CODIGO_FIM
    | WHILE '(' expressao ')' CODIGO_COMECO comandos CODIGO_FIM
    | FOR POR VAR PAGINAS CODIGO_COMECO comandos CODIGO_FIM
    | CHAMA IDENT '(' ')' ';'
;

tipo:
      INT
    | FLOAT
    | DOUBLE
    | CHAR
;

expressao:
      NUMBER
    | IDENT {
		if(!simbolo_existe($1))
			simbolo_novo($1, IDENT);
	}
    | expressao '+' expressao
    | expressao '-' expressao
    | expressao '*' expressao
    | expressao '/' expressao
    | '(' expressao ')'
;

%%

int yyerror(const char *s) {
    errorc++;
    printf("erro %d: %s\n", errorc, s);
    return 1;
}

simbolo *simbolo_novo(char *nome, int token){
	tsimbolos[simbolo_qtd].nome = nome;
	tsimbolos[simbolo_qtd].token = token;
	simbolo *result = &tsimbolos[simbolo_qtd];
	simbolo_qtd++;
	return result;
}

bool simbolo_existe(char *nome){
	for(int i = 0; i < simbolo_qtd; i++){
		if(strcmp(tsimbolos[i].nome,nome) == 0){
			return true;
		}
	}
	return false;
}

void debug(){
	printf("Simbolos:\n");
	for(int i = 0; i < simbolo_qtd; i++){
		printf("\t%s\n",tsimbolos[i].nome);
	}
}

int main(void) {
    yyparse();
    debug();
    if (errorc == 0)
        printf("Quadrinho compilado com sucesso!\n");
    return 0;
}

