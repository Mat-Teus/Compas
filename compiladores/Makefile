all:

	flex quadrinhos.l
	bison -d quadrinhos.y
	gcc lex.yy.c quadrinhos.tab.c -o quadcmp

	./quadcmp < teste_de_fogo.quad
	./quadcmp < tabuada.quad
	./quadcmp < helloworld.quad
	./quadcmp < errado.quad
	./quadcmp < errado2.quad
	./quadcmp < errado3.quad
