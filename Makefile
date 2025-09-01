TARGET = bin/ahadu
SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c, obj/%.o, $(SRC))
CC = gcc
CFLAGS = -Iinclude
DEBUG_FLAGS = -g -O0 -Wall

# Default build
default: $(TARGET)

# Ensure bin/ and obj/ exist
dirs:
	mkdir -p bin obj

# Build target (depends on dirs existing)
$(TARGET): dirs $(OBJ)
	$(CC) -o $@ $^

# Compile objects (depends on obj/ existing)
obj/%.o : src/%.c | dirs
	$(CC) -c $< -o $@ $(CFLAGS)

# Run the program
run: $(TARGET)
	./$(TARGET)

# Debug build
debug: CFLAGS += $(DEBUG_FLAGS)
debug: clean $(TARGET)

# Run with valgrind
valgrind: debug
	valgrind --leak-check=full --show-leak-kinds=all ./$(TARGET)

# Clean
clean:
	rm -f obj/*.o
	rm -f bin/*
