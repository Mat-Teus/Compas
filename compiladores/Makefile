all:

	flex quadrinhos.l
	bison -d quadrinhos.y
	gcc lex.yy.c quadrinhos.tab.c -o quadcmp
