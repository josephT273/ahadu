TARGET = bin/ahadu
SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c, obj/%.o, $(SRC))
CC = gcc
CFLAGS = -Iinclude
DEBUG_FLAGS = -g -O0 -Wall

# Default build
default: $(TARGET)

# Build target
$(TARGET): $(OBJ)
	$(CC) -o $@ $^

# Normal object compilation
obj/%.o : src/%.c
	$(CC) -c $< -o $@ $(CFLAGS)

# Run the program
run: $(TARGET)
	./$(TARGET)

# Build with debug symbols
debug: CFLAGS += $(DEBUG_FLAGS)
debug: clean $(TARGET)

# Run with valgrind (memory check)
valgrind: debug
	valgrind --leak-check=full --show-leak-kinds=all ./$(TARGET)

# Clean build artifacts
clean:
	rm -f obj/*.o
	rm -f bin/*
