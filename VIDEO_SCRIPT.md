# Compiler Demonstration Video Script
## CST-405 Complete Compiler Project
**Duration: 3 minutes**
**Authors: Christian Nshuti Manzi & Aime Serge Tuyishime**

---

## INTRODUCTION (0:00 - 0:25)

**[Show terminal/screen]**

"Hello! Today we'll demonstrate our complete compiler for CST-405. This compiler translates source code into assembly language that runs on your computer.

Our compiler has 5 phases:
1. **Lexical Analysis** - breaks code into tokens
2. **Syntax Analysis** - builds an Abstract Syntax Tree
3. **Semantic Analysis** - checks types and variables
4. **Intermediate Code** - creates Three-Address Code
5. **Code Generation** - produces x86-64 assembly

Let's see it in action!"

---

## PART A: INDIVIDUAL TASKS COMPLETED (0:25 - 0:50)

**[Show code files briefly]**

"Here's what we each completed:

**Christian worked on:**
- Lexer (scanner.l) - recognizes all tokens and handles comments
- Parser (parser.y) - builds the syntax tree from tokens
- Semantic analyzer - checks variable declarations and types

**Aime worked on:**
- Intermediate code generator - creates Three-Address Code from AST
- Assembly code generator - produces x86-64 assembly code
- While loop feature - our new addition with relational operators

Together we integrated all parts and created comprehensive tests."

---
















## PART D: DEMONSTRATION (2:00 - 2:55)

**[Open terminal]**

"Now let's run the compiler!

**Test 1: Basic Program**"

```bash
cat test_basic.src
```

**[Show: declares variables, does math]**

"Compile it:"

```bash
./compiler test_basic.src
```

**[Let phases show briefly]**

"See all 5 phases complete! Now assemble and run:"

```bash
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program
```

**[Output: 30, 10, 20]**

"Perfect! Prints 30, 10, 20.

**Test 2: While Loop**"

```bash
cat test_while.src
```

**[Show: counts from 0 to 4, sums them]**

"Compile and run:"

```bash
./compiler test_while.src
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program
```

**[Output: 0, 1, 2, 3, 4, 10]**

"Excellent! Counts 0-4, then prints sum of 10!"

---

## CONCLUSION (2:55 - 3:00)

"That's our complete compiler - from source code to running assembly. Thanks for watching!"

---

## QUICK REFERENCE: COMMANDS TO RUN

```bash
# View test program
cat test_basic.src

# Compile the source code
./compiler test_basic.src

# Assemble to object file
nasm -f elf64 output.asm -o output.o

# Link to executable
gcc output.o -o program -no-pie

# Run the program
./program

# Test while loops
cat test_while.src
./compiler test_while.src
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program
```

---

## RECORDING TIPS

1. **Practice first** - Run all commands beforehand to ensure they work
2. **Keep font large** - Make terminal easily readable
3. **Speak clearly** - Don't rush, aim for exactly 3 minutes
4. **Show confidence** - You built an impressive compiler!
5. **Simple diagrams** - Draw AST on paper if needed, keep it simple
6. **If something fails** - Stay calm, have backup commands ready

---

## TROUBLESHOOTING

**If compiler needs rebuilding:**
```bash
make clean
make all
```

**Check tools are installed:**
```bash
flex --version
bison --version
nasm --version
gcc --version
```

**Use simpler test if needed:**
```bash
./compiler test_basic.src
```

---

## OPTIONAL: SIMPLE AST DIAGRAM TO DRAW

For `z = x + y;`

```
Draw on paper:

    =
   / \
  z   +
     / \
    x   y
```

Point and explain: "This tree shows structure - assignment at top, addition below."

---

**Remember: Keep it simple, clear, and under 3 minutes. You've got this!**
