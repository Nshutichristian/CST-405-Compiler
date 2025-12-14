# Ultimate Compiler Demo Guide

## Quick Demo (3 minutes)

### Option 1: Run the automated script
```bash
./run_demo.sh
```
Then enter: `10`, `5`, `3`

### Option 2: Manual demo
```bash
./compiler test_ultimate_demo.c
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program
```

## What Each Output Shows

When you input **10, 5, 3**, you'll see:

| Output | Calculation | What It Demonstrates |
|--------|-------------|---------------------|
| 15 | 10 + 5 | Basic addition |
| 5 | 10 - 5 | Basic subtraction |
| 50 | 10 * 5 | Basic multiplication |
| 2 | 10 / 5 | Basic division |
| 45 | (10 + 5) * 3 | Parentheses handling |
| 79 | (10×5) + (3×10) - (5/3) | Multiple operations |
| -21 | ((10+5) × (3-10)) / 5 | Nested parentheses |
| 16 | (1+2)×3 - 9/3 + 5×2 | Operator precedence |
| 15 | ((12+8) × (5-2)) / (3+1) | Deep nesting |
| 40 | (10+5×2) - (20/4) + ((3+2)×(6-1)) | Ultimate complexity |

## Features Demonstrated

✅ **Interactive Input** - `read()` function prompts for user input
✅ **All Operations** - Addition, subtraction, multiplication, division, modulo
✅ **Operator Precedence** - Multiplication/division before addition/subtraction
✅ **Parentheses** - Complex nested expressions
✅ **Optimization** - Compiler optimizes constant expressions
✅ **Type Safety** - Semantic analysis catches errors
✅ **Security** - Detects buffer overflows, division by zero
✅ **Dual Targets** - Generates both x86-64 and MIPS assembly

## What Makes This Impressive

1. **Complex Expression Parsing**: The compiler correctly parses expressions like `(10 + 5 * 2) - (20 / 4) + ((3 + 2) * (6 - 1))`

2. **Proper Precedence**: Automatically handles `*` and `/` before `+` and `-`

3. **Nested Parentheses**: Can handle unlimited nesting depth

4. **Optimization**: Constant expressions like `(1 + 2) * 3` get evaluated at compile time

5. **Interactive**: Unlike most student compilers, this one can read user input!

## Talking Points for Your Video

"My compiler can handle complex expressions that most student compilers can't..."

"Notice how it correctly handles nested parentheses and operator precedence..."

"The `read()` function makes it interactive - you can enter your own numbers..."

"Let me show you some truly complex expressions..." (run the ultimate demo)

"And here's the generated assembly code..." (cat output.asm)

"The compiler also tracks performance..." (point to execution time)

## Expression Examples You Can Talk About

**Simple**: `a + b * c`
→ Shows it does multiplication before addition

**Nested**: `((a + b) * (c - a)) / b`
→ Shows it handles multiple levels of parentheses

**Ultimate**: `(10 + 5 * 2) - (20 / 4) + ((3 + 2) * (6 - 1))`
→ Shows it can handle production-level complexity

## Files Included

- `test_ultimate_demo.c` - The main demo program
- `test_complex_calc.c` - Interactive calculator with complex expressions
- `test_demo.c` - Simple 4-operation calculator
- `test_interactive.c` - Basic addition demo
- `run_demo.sh` - Automated demo script
