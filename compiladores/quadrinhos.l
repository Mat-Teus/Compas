%{
#include "quadrinhos.tab.h"
%}

%%
[ \t\r\n]                { }
"inicio do quadrinho"    { return COMECA; }
"fim do quadrinho"       { return TERMINA; }

"Historia"               { return MAIN; }
"Fim da Historia"        { return FIM_MAIN; }

"Painel"                 { return FUNCAO; }
"Fim do Painel"          { return FIM_FUNCAO; }

"balao"                  { return PRINT; }
"se_personagem"          { return IF; }
"senao"                  { return ELSE; }
"sarjeta"                { return WHILE; }
"splash_page"            { return FOR; }
"por"			 { return POR; }
"paginas"		 {return PAGINAS; }
"personagem"             { return VAR; }
"chama"                  { return CHAMA; }
"pow"			 { return ONOMATOPEIA; }

"protagonista"           { return INT; }
"heroi"                  { return FLOAT; }
"antiheroi"               { return DOUBLE; }
"vilao"                  { return CHAR; }

"["                      { return CODIGO_COMECO; }
"]"                      { return CODIGO_FIM; }

[0-9]+                   { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.nome = strdup(yytext); return IDENT; }

"+"                      { return '+'; }
"-"                      { return '-'; }
"*"                      { return '*'; }
"/"                      { return '/'; }
"("                      { return '('; }
")"                      { return ')'; }
"="                      { return '='; }
";"                      { return ';'; }

.                        { return yytext[0]; }
%%

int yywrap() { return 1; }

