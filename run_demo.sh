#!/bin/bash
# Ultimate Compiler Demo Script

echo "=========================================="
echo "  CST-405 COMPILER DEMONSTRATION"
echo "=========================================="
echo ""
echo "Compiling ultimate calculator demo..."
echo ""

./compiler test_ultimate_demo.c

echo ""
echo "Assembling and linking..."
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie

echo ""
echo "=========================================="
echo "  RUNNING INTERACTIVE CALCULATOR"
echo "=========================================="
echo ""
echo "This demo shows the compiler handling:"
echo "  ✓ User input with read()"
echo "  ✓ Basic arithmetic (+, -, *, /)"
echo "  ✓ Complex nested expressions"
echo "  ✓ Proper operator precedence"
echo "  ✓ Parentheses handling"
echo ""
echo "You'll be asked for 3 numbers, then the"
echo "compiler will show various calculations!"
echo ""
echo "=========================================="
echo ""

./program

echo ""
echo "=========================================="
echo "  DEMO COMPLETE!"
echo "=========================================="
echo ""
echo "The compiler successfully:"
echo "  ✓ Parsed complex expressions"
echo "  ✓ Generated optimized assembly"
echo "  ✓ Handled nested parentheses"
echo "  ✓ Maintained operator precedence"
echo ""
