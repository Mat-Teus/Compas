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
    int num;
}

%token COMECA TERMINA
%token MAIN FIM_MAIN
%token FUNCAO FIM_FUNCAO
%token MAIOR MENOR IGUAL DIFERENTE
%token PRINT IF ELSE WHILE FOR POR PAGINAS VAR CHAMA ONOMATOPEIA SWITCH PAGINA
%token INT FLOAT DOUBLE CHAR STRING CARACTER
%token CODIGO_COMECO CODIGO_FIM
%token NUMBER
%token IDENT 
%left '+' '-'
%left '*' '/'
%left MENOR MAIOR IGUAL DIFERENTE '<' '>'

%type <nome> IDENT STRING CARACTER

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
      PRINT STRING ONOMATOPEIA
    | VAR tipo IDENT ONOMATOPEIA {
          if(!simbolo_existe($3)) simbolo_novo($3, 0);
      }
    | VAR tipo IDENT '=' expressao ONOMATOPEIA {
          if(!simbolo_existe($3)) simbolo_novo($3, 0);
      }
    | IDENT '=' expressao ONOMATOPEIA
    | IF '(' expressao ')' CODIGO_COMECO comandos CODIGO_FIM
    | IF '(' expressao ')' CODIGO_COMECO comandos CODIGO_FIM ELSE CODIGO_COMECO comandos CODIGO_FIM
    | WHILE '(' expressao ')' CODIGO_COMECO comandos CODIGO_FIM
    | FOR POR reboco PAGINAS CODIGO_COMECO comandos CODIGO_FIM
    | SWITCH '(' IDENT ')' CODIGO_COMECO paginas CODIGO_FIM
    | CHAMA '(' IDENT ')' ONOMATOPEIA
;

paginas:
      pagina
    | pagina paginas
;

pagina:
      PAGINA NUMBER ':' comandos
;

reboco:
      IDENT
    | NUMBER
;

tipo:
      INT
    | FLOAT
    | DOUBLE
    | CHAR
;

expressao:
      NUMBER
    | IDENT
    | CARACTER
    | '(' expressao ')'
    | expressao '+' expressao
    | expressao '-' expressao
    | expressao '*' expressao
    | expressao '/' expressao
    | expressao IGUAL expressao
    | expressao DIFERENTE expressao
    | expressao MAIOR expressao
    | expressao MENOR expressao
    | expressao '<' expressao
    | expressao '>' expressao
;


%%

int yyerror(const char *s) {
    errorc++;
    printf("erro %d: %s\n", errorc, s);
    return 1;
}

simbolo *simbolo_novo(char *nome, int token){
	tsimbolos[simbolo_qtd].nome = strdup(nome); // faz cópia segura
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
    if (errorc == 0)
        printf("Quadrinho compilado com sucesso!\n");

    debug();
    return 0;
}

