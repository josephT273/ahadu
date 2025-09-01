TARGET = bin/ahadu
SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c, obj/%.o, $(SRC))

default: $(TARGET)

clean:
	rm -f obj/*.o
	rm -f bin/*

$(TARGET): $(OBJ)
	gcc -o $@ $?

run:
	./bin/ahadu

obj/%.o : src/%.c
	gcc -c $< -o $@ -Iinclude
