Quadrinhos é uma linguagem de programação inspirada na escrita de quadrinhos, permitindo que programas sejam estruturados como histórias, painéis e páginas. Cada elemento da linguagem representa um aspecto da narrativa de quadrinhos.

Se começa com "inicio do quadrinho" e termina com "fim do quadrinho". Dentro deste bloco, pode-se declarar o bloco principal da história usando "Historia" seguido de colchetes para delimitar os comandos, finalizando com "Fim da Historia". Funções, chamadas de painéis, podem ser definidas usando "Painel" seguido do nome do painel, comandos entre colchetes e finalizando com "Fim do Painel". Para chamar um painel dentro da história, utiliza-se "sangria" seguido do nome do painel entre parênteses.

A linguagem permite comandos de saída através de balões, usando "balao" seguido de uma string e finalizando com "pow", que representa uma onomatopeia típica dos quadrinhos. Variáveis são declaradas como personagens, usando "personagem" seguido do tipo, que pode ser "protagonista" (INT), "heroi" (FLOAT), "antiheroi" (DOUBLE) ou "vilao" (CHAR), seguido do identificador da variável e finalizando com "pow". Atribuições também são possíveis, usando "=" antes do "pow"

Condições usam "se_personagem" para verificar uma expressão e "senao" para a alternativa, com comandos delimitados por colchetes. Loops podem ser criados com "sarjeta" para while e "splash_page por paginas" é usado como for, o switch é usado como marca_pagina seguido de um identificador e um bloco de páginas numeradas, permitindo executar diferentes páginas de acordo com o valor da variável ou expressão.  

Expressões aceitam operadores aritméticos "+", "-", "*", "/" e comparações "==", "!=", ">=", "<=", ">", "<"

Programa exemplo:

inicio do quadrinho

Historia[
  balao "ola mundo" pow
  personagem protagonista x pow
]Fim da Historia

fim do quadrinho
