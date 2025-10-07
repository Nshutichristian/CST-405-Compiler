# CST-405 COMPLETE CLEAN & RUN GUIDE

## 🧹 STEP 1: COMPLETE CLEANUP (Start Fresh)

### In WSL Terminal:

```bash
# Navigate to project
cd /mnt/f/PROJECTS/CST\ 405/PROJECT/CST-405

# Clean ALL generated files
make -f Makefile_new clean

# Remove any leftover files
rm -f compiler *.o lex.yy.c parser.tab.c parser.tab.h parser.output
rm -f output.asm output.o program

# Verify everything is clean
ls -la

# You should only see source files (.c, .h, .l, .y, .src, .md, .txt, Makefile_new)
```

---

## 📥 STEP 2: GET LATEST CODE FROM GITHUB

```bash
# Make sure you have the latest version
git pull origin main

# Check status - should be clean
git status
```

---

## 🔨 STEP 3: BUILD THE COMPILER

```bash
# Build from scratch
make -f Makefile_new

# You should see:
# - Generating parser with Bison...
# - Compiling parser...
# - Generating lexer with Flex...
# - Compiling lexer...
# - Compiling AST module...
# - Compiling symbol table module...
# - Compiling semantic analyzer...
# - Compiling IR code generator...
# - Compiling code generator...
# - Compiling main compiler driver...
# - Linking compiler...
# - ✓ Compiler built successfully: compiler

# Verify compiler exists
ls -l compiler
```

---

## ✅ STEP 4: TEST BASIC PROGRAM

```bash
# Compile basic test
./compiler test_basic.src

# You should see:
# - Banner (CST-405 Complete Compiler System)
# - Phase 1 & 2: Lexical and Syntax Analysis
# - Phase 3: Semantic Analysis
# - Abstract Syntax Tree
# - Symbol Table
# - Phase 4: Intermediate Code Generation
# - Three-Address Code (TAC)
# - Phase 5: Assembly Code Generation
# - ✓ Compilation successful!

# Check assembly was generated
ls -l output.asm
```

---

## 🏃 STEP 5: ASSEMBLE AND RUN

```bash
# Assemble to object file
nasm -f elf64 output.asm -o output.o

# Link to executable (no warning now!)
gcc output.o -o program -no-pie

# Run the program
./program

# Expected Output:
# 30
# 10
# 20
```

---

## 🔄 STEP 6: TEST WHILE LOOPS (NEW FEATURE)

```bash
# Clean previous output
rm -f output.asm output.o program

# Compile while loop test
./compiler test_while.src

# Assemble and run
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program

# Expected Output:
# 0
# 1
# 2
# 3
# 4
# 10
```

---

## 🎯 STEP 7: TEST COMPLEX PROGRAM

```bash
# Clean previous output
rm -f output.asm output.o program

# Compile complex test
./compiler test_complex.src

# Assemble and run
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program

# Expected Output:
# 15
# 10
# 9
# 8
# 7
# 6
# 5
# 4
# 3
# 2
# 1
# 10
```

---

## 📹 STEP 8: PREPARE FOR VIDEO RECORDING

### Terminal Setup

```bash
# Clear screen for clean recording
clear

# Optional: Increase font size for visibility
# Right-click Ubuntu title bar → Properties → Font → Size 20
```

### Open These Files in Separate Windows

1. **VIDEO_SCRIPT.md** - Your speaking script
2. **test_while.src** - To show while loop code
3. **parser.y** - To show grammar
4. **A text editor** - For live viewing

---

