# Can use MAKE file instead
#   Deleting object files 

echo "Deleting object files ..."
if [ -e a.out ]; then
  rm a.out
fi

if [ -e y.tab.c ]; then
  rm y.tab.c 
fi

if [ -e y.tab.o ]; then
  rm y.tab.o 
fi

if [ -e lex.yy.o ]; then 
  rm lex.yy.o 
fi

if [ -e lex.yy.c ]; then 
  rm lex.yy.c
fi

if [ -e y.output ]; then 
  rm y.output
fi

if [ -e y.tab.h ]; then 
  rm y.tab.h
fi

# Compile 
echo "Running yacc ..."
yacc -d -v toy.y

echo "Running lex ..."
lex toy.l

echo "Compiling ..."
cc lex.yy.c y.tab.c -ly -ll 

echo "Piping input.toy to the input stream ..."
./a.out < input.toy

