# CST-405 Complete Compiler Makefile
# Builds the complete compiler with all phases

CC = gcc
LEX = flex
BISON = bison
CFLAGS = -g -Wall -Wno-unused-function
LEXER_TARGET = lexer
COMPILER_TARGET = compiler

# Default target - build complete compiler
all: $(COMPILER_TARGET)

# Complete compiler with all phases
$(COMPILER_TARGET): parser.tab.o lex.yy.o compiler.o ast.o symtable.o semantic.o ircode.o codegen.o
	@echo "Building complete compiler..."
	$(CC) $(CFLAGS) -o $(COMPILER_TARGET) $^
	@echo "✓ Complete compiler built successfully!"

# Generate parser from Bison
parser.tab.c parser.tab.h: parser.y
	@echo "Generating parser with Bison..."
	$(BISON) -d parser.y

# Generate lexer source code from Flex
lex.yy.c: scanner.l parser.tab.h
	@echo "Generating lexer with Flex..."
	$(LEX) scanner.l

# Object file rules
parser.tab.o: parser.tab.c parser.tab.h ast.h symtable.h
	$(CC) $(CFLAGS) -c parser.tab.c

lex.yy.o: lex.yy.c parser.tab.h
	$(CC) $(CFLAGS) -c lex.yy.c

compiler.o: compiler.c ast.h symtable.h semantic.h ircode.h codegen.h
	$(CC) $(CFLAGS) -c compiler.c

ast.o: ast.c ast.h
	$(CC) $(CFLAGS) -c ast.c

symtable.o: symtable.c symtable.h
	$(CC) $(CFLAGS) -c symtable.c

semantic.o: semantic.c semantic.h ast.h symtable.h
	$(CC) $(CFLAGS) -c semantic.c

ircode.o: ircode.c ircode.h ast.h
	$(CC) $(CFLAGS) -c ircode.c

codegen.o: codegen.c codegen.h ircode.h symtable.h
	$(CC) $(CFLAGS) -c codegen.c

# Test targets
test: $(COMPILER_TARGET)
	@echo "\n=== Testing Complete Compiler ==="
	@echo "Testing basic program..."
	./$(COMPILER_TARGET) test_basic.src
	@echo "\n=== Testing while loop feature ==="
	./$(COMPILER_TARGET) test_while.src
	@echo "\n=== Testing complex program ==="
	./$(COMPILER_TARGET) test_complex.src

# Run single test
test-basic: $(COMPILER_TARGET)
	@echo "Testing basic program..."
	./$(COMPILER_TARGET) test_basic.src

test-while: $(COMPILER_TARGET)
	@echo "Testing while loop feature..."
	./$(COMPILER_TARGET) test_while.src

test-complex: $(COMPILER_TARGET)
	@echo "Testing complex program..."
	./$(COMPILER_TARGET) test_complex.src

# Installation verification
verify-install:
	@echo "Verifying build tools installation:"
	@echo "===================================="
	@echo "Flex version:"
	@flex --version 2>/dev/null || echo "❌ Flex not installed"
	@echo "\nBison version:"
	@bison --version 2>/dev/null || echo "❌ Bison not installed"
	@echo "\nGCC version:"
	@gcc --version 2>/dev/null || echo "❌ GCC not installed"

# Clean up generated files
clean:
	@echo "Cleaning up generated files..."
	rm -f $(COMPILER_TARGET)
	rm -f lex.yy.c lex.yy.o
	rm -f parser.tab.c parser.tab.h parser.tab.o
	rm -f *.o output.asm output.o program
	@echo "✓ Cleanup complete"

# Help target
help:
	@echo "CST-405 Complete Compiler - Build Commands"
	@echo "=========================================="
	@echo "make              - Build complete compiler"
	@echo "make test         - Run all test programs"
	@echo "make test-basic   - Test basic features"
	@echo "make test-while   - Test while loop feature"
	@echo "make test-complex - Test complex program"
	@echo "make clean        - Remove generated files"
	@echo "make verify-install - Check build tools"
	@echo ""
	@echo "To run compiler manually:"
	@echo "  ./compiler <source_file>"
	@echo ""
	@echo "To assemble and run generated code:"
	@echo "  nasm -f elf64 output.asm -o output.o"
	@echo "  gcc output.o -o program -no-pie"
	@echo "  ./program"

.PHONY: all clean test test-basic test-while test-complex verify-install help
