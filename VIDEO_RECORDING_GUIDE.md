# Video Recording Guide - CST-405 Compiler Demonstration

**Authors:** Christian Nshuti Manzi & Aime Serge Tuyishime
**Project:** Complete Compiler Implementation
**Duration:** 10-15 minutes recommended

---

## Video Structure Overview

Your video should cover these sections:
1. **Introduction** (1-2 min)
2. **Code Explanation** (3-4 min)
3. **Individual Task Breakdown** (2-3 min)
4. **AST to Code Generation Process** (3-4 min)
5. **Live Demonstration** (2-3 min)
6. **Conclusion** (1 min)

---

## Part 1: INTRODUCTION (1-2 minutes)

### What to Say:
```
"Hello, I'm [Your Name], and this is our CST-405 Complete Compiler project.

This compiler was developed by Christian Nshuti Manzi and Aime Serge Tuyishime.

Today I'll demonstrate a fully functional compiler that implements all six
compilation phases - from lexical analysis through assembly code generation.

Our compiler supports a minimal programming language with variables,
assignments, print statements, and arithmetic expressions.

Most importantly, we added a SIGNIFICANT FEATURE: while loops with six
relational operators, which required modifications in every single compiler
phase.

Let's start by showing you the complete project structure."
```

### What to Show on Screen:
```bash
# Show the project directory
ls -la

# Show the main files
echo "=== Source Files ==="
ls *.c *.h *.l *.y

echo "=== Test Programs ==="
ls test_*.src

echo "=== Documentation ==="
ls *.md
```

---

## Part 2: CODE EXPLANATION (3-4 minutes)

### Section A: Architecture Overview

#### What to Say:
```
"Our compiler follows the classic multi-phase architecture. Let me walk you
through each component and how they work together."
```

#### What to Show:
```bash
# Show the compiler phases visually
cat << 'EOF'
┌─────────────────┐
│  Source Code    │  test_while.src
│  (.src file)    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 1. LEXER        │  scanner.l (Flex)
│    Tokenization │  → Tokens (INT, ID, WHILE, <, etc.)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 2. PARSER       │  parser.y (Bison)
│    Syntax Tree  │  → AST (Abstract Syntax Tree)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 3. SEMANTIC     │  semantic.c
│    Analysis     │  → Type checking, variable validation
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 4. IR CODE      │  ircode.c
│    Generation   │  → TAC (Three-Address Code)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ 5. CODE GEN     │  codegen.c
│    Assembly     │  → x86-64 Assembly (output.asm)
└─────────────────┘
EOF
```

### Section B: Key Code Walkthrough

#### Show scanner.l:
```bash
# Open scanner.l
cat scanner.l | head -60
```

**What to Explain:**
```
"The lexer uses Flex to recognize tokens. Here you can see:
- Keywords like 'int', 'print', and our NEW 'while' keyword
- Six relational operators: <, >, <=, >=, ==, !=
- Braces for code blocks
- Each token is returned to the parser with location information for error reporting"
```

#### Show parser.y:
```bash
# Show the grammar rules
cat parser.y | grep -A 10 "while_stmt:"
```

**What to Explain:**
```
"The parser defines the grammar rules. This is our while loop rule:
  while_stmt → WHILE LPAREN condition RPAREN LBRACE statement_list RBRACE

This builds an AST node containing:
- The condition (which expression to check)
- The body (which statements to execute)

The parser calls AST construction functions to build the tree structure."
```

#### Show AST structure:
```bash
# Show AST node types
grep -A 5 "typedef enum" ast.h
```

**What to Explain:**
```
"The AST uses different node types for each language construct:
- NODE_WHILE for loop structures
- NODE_CONDITION for relational comparisons
- NODE_BINARY_OP for arithmetic
- Each node stores its children and relevant data"
```

---

## Part 3: INDIVIDUAL TASK BREAKDOWN (2-3 minutes)

### What to Say:
```
"Now let me outline how we divided the work for this project."
```

### Task Division Example:

#### Christian's Tasks:
```
"Christian was responsible for:

1. LEXICAL ANALYSIS (scanner.l)
   - Implemented all token recognition patterns
   - Added while keyword and relational operators
   - Implemented location tracking for error messages

2. PARSER (parser.y)
   - Defined the complete grammar
   - Added while loop and condition rules
   - Implemented AST construction calls

3. SYMBOL TABLE (symtable.c/h)
   - Implemented hash table structure
   - Created symbol lookup and insertion functions
   - Added initialization tracking

Let me show you the lexer implementation..."
```

#### Show Example:
```bash
# Show the while keyword token
grep -A 3 '"while"' scanner.l

# Show relational operators
grep -A 3 '"<="' scanner.l
```

#### Aime's Tasks:
```
"Aime was responsible for:

1. SEMANTIC ANALYSIS (semantic.c)
   - Type checking for expressions and conditions
   - Variable declaration checking
   - Use-before-initialization detection

2. INTERMEDIATE CODE (ircode.c)
   - TAC instruction generation
   - Label and temporary variable generation
   - While loop control flow with jumps

3. CODE GENERATION (codegen.c)
   - x86-64 assembly generation
   - Relational operator implementations (6 variants)
   - Jump instruction generation

Let me show you the IR code generation..."
```

#### Show Example:
```bash
# Show while loop TAC generation
grep -A 30 "case NODE_WHILE:" ircode.c
```

---

## Part 4: AST TO CODE GENERATION PROCESS (3-4 minutes)

### This is the MOST IMPORTANT SECTION - Explain it thoroughly!

#### What to Say:
```
"Now, let me explain the most important part: how we transform the
Abstract Syntax Tree into intermediate code and then assembly code.

This process happens in two stages:
1. AST → Three-Address Code (TAC)
2. TAC → x86-64 Assembly

Let me walk through a real example."
```

### Live Example: Show the transformation

#### Step 1: Show Source Code
```bash
cat test_while.src
```

**What to Say:**
```
"Here's our source program. It has a while loop that counts from 0 to 4.
Let's trace how this becomes machine code."
```

#### Step 2: Build and Show AST
```bash
./compiler test_while.src 2>&1 | grep -A 30 "ABSTRACT SYNTAX TREE"
```

**What to Explain:**
```
"When we parse the source code, we get this AST structure.

Look at the WHILE node:
- It has a CONDITION child: counter < limit
- It has a BODY child: the statements inside the loop

The AST is a tree representation that preserves the program structure.
Now watch how we convert this to linear TAC..."
```

#### Step 3: Show TAC Generation Process

**Open ircode.c and explain:**
```bash
# Show the while loop TAC generation
cat ircode.c | grep -A 40 "case NODE_WHILE:"
```

**What to Explain (DETAILED):**
```
"The TAC generation for while loops follows this algorithm:

1. Generate a START LABEL (L0:)
   - This marks where the loop begins

2. Evaluate the CONDITION
   - Generate code for the expression
   - Store result in a temporary (t1 = counter < limit)

3. Generate CONDITIONAL JUMP
   - if_false t1 goto END_LABEL
   - If condition is false (0), exit the loop

4. Generate BODY CODE
   - Recursively generate TAC for loop statements

5. Generate GOTO START
   - Jump back to beginning of loop

6. Generate END LABEL (L1:)
   - Marks where to jump when exiting

This creates the loop structure in linear form."
```

#### Step 4: Show Actual TAC Output
```bash
./compiler test_while.src 2>&1 | grep -A 20 "THREE-ADDRESS CODE"
```

**Point to specific lines:**
```
"Look at the generated TAC:

Line 4: L0:                    ← Loop start label
Line 5: t3 = counter < limit   ← Evaluate condition (RELOP instruction)
Line 6: if_false t3 goto L1    ← Exit if false
Lines 7-11: [loop body]        ← Execute statements
Line 12: goto L0               ← Jump back to start
Line 13: L1:                   ← Loop end label

This is EXACTLY the structure we programmed in ircode.c!"
```

#### Step 5: Show Assembly Generation Process

**Open codegen.c and explain:**
```bash
# Show TAC_RELOP handling
cat codegen.c | grep -A 20 "case TAC_RELOP:"
```

**What to Explain:**
```
"Now we convert each TAC instruction to assembly.

For the relational operation (counter < limit):

1. Load left operand into RAX register
   mov rax, [counter]

2. Compare with right operand
   cmp rax, [limit]

3. Set result based on comparison
   setl al        ; Set AL to 1 if less than

4. Zero-extend to 64-bit and store
   movzx rax, al
   mov [t3], rax

For different operators, we use different 'set' instructions:
- < uses setl  (set if less)
- > uses setg  (set if greater)
- <= uses setle (set if less or equal)
- And so on for all 6 operators"
```

#### Step 6: Show Actual Assembly
```bash
cat output.asm | grep -A 30 "L0:"
```

**Point to specific sections:**
```
"Here's the generated assembly:

L0:                          ← Loop start (matches TAC)
    mov rax, [counter]       ← Load counter
    cmp rax, [limit]         ← Compare
    setl al                  ← Set if counter < limit
    movzx rax, al           ← Extend to 64-bit
    mov [t3], rax           ← Store result

    mov rax, [t3]           ← Load condition result
    cmp rax, 0              ← Check if zero (false)
    je L1                   ← Jump to L1 if false

    [loop body instructions]

    jmp L0                  ← Jump back to start

L1:                         ← Loop end (matches TAC)

Every TAC instruction became assembly instructions!"
```

### Summary Diagram:

**Show this on screen:**
```
SOURCE CODE:
  while (counter < limit) {
    print(counter);
  }
       ↓
AST:
  WHILE
  ├── CONDITION: <
  │   ├── counter
  │   └── limit
  └── BODY: print(counter)
       ↓
TAC:
  L0:
  t1 = counter < limit
  if_false t1 goto L1
  print counter
  goto L0
  L1:
       ↓
ASSEMBLY:
  L0:
    mov rax, [counter]
    cmp rax, [limit]
    setl al
    movzx rax, al
    mov [t1], rax
    mov rax, [t1]
    cmp rax, 0
    je L1
    [print code]
    jmp L0
  L1:
```

---

## Part 5: LIVE DEMONSTRATION (2-3 minutes)

### Build Process

```bash
echo "=== STEP 1: Clean Build ==="
make clean
make

echo "=== STEP 2: Compilation Successful ==="
ls -lh compiler
```

**What to Say:**
```
"The compiler built successfully with no errors or warnings.
Now let's compile our test programs."
```

### Test 1: Basic Features
```bash
echo "=== Testing Basic Features ==="
./compiler test_basic.src
```

**What to Say:**
```
"This shows all compilation phases working:
- Lexical analysis ✓
- Syntax analysis ✓
- Semantic analysis ✓
- TAC generation ✓
- Assembly generation ✓

Notice the detailed output for each phase."
```

### Test 2: While Loop Feature
```bash
echo "=== Testing While Loop Feature ==="
./compiler test_while.src
```

**What to Say:**
```
"Now watch our NEW FEATURE - while loops - go through all phases.

Notice:
- The lexer recognizes 'while' and '<'
- The parser builds a WHILE node
- Semantic analysis checks the condition type
- IR generates labels L0 and L1
- Assembly has comparison and jump instructions

This demonstrates that our feature touches EVERY phase!"
```

### Test 3: Show Generated Assembly
```bash
echo "=== Generated Assembly Code ==="
cat output.asm | head -50
```

**What to Say:**
```
"Here's the actual x86-64 assembly code our compiler generated.
It's complete, correct, and ready to assemble and run!"
```

### Test 4: (OPTIONAL) Assemble and Run
```bash
# Only if you have NASM installed
echo "=== Assembling and Running ==="
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program
```

**What to Say:**
```
"And here it is actually executing! The program prints 0, 1, 2, 3, 4,
then the sum of 10. This proves our compiler generates working code!"
```

---

## Part 6: CONCLUSION (1 minute)

### What to Say:
```
"To summarize:

We built a COMPLETE compiler with all six phases:
✓ Lexical analysis with Flex
✓ Syntax analysis with Bison
✓ Semantic analysis with type checking
✓ IR code generation using TAC
✓ Assembly code generation for x86-64

We added a SIGNIFICANT FEATURE - while loops with relational operators:
✓ 8 new tokens in the lexer
✓ 2 new grammar rules in the parser
✓ 2 new AST node types
✓ Label-based control flow in TAC
✓ Comparison and jump instructions in assembly
✓ 345 lines of new code
✓ Touches ALL phases

The compiler successfully compiles and generates working assembly code.

This project demonstrates complete mastery of compiler construction
from lexical analysis through code generation.

Thank you for watching!"
```

---

## RECORDING TIPS

### Before Recording:
```bash
# 1. Clean everything
make clean
rm -f output.asm output.o program

# 2. Test your demo commands
./compiler test_basic.src
./compiler test_while.src

# 3. Prepare your terminal
# - Use large font (16-18pt)
# - Use high contrast theme
# - Clear scrollback
clear

# 4. Have files ready to show
ls *.c *.h *.l *.y test_*.src *.md
```

### During Recording:

1. **Speak Clearly and Slowly**
   - Pause between major points
   - Explain technical terms
   - Use simple language

2. **Show, Don't Just Tell**
   - Open files and point to specific code
   - Highlight important lines
   - Show output at each phase

3. **Use Visual Aids**
   - Draw diagrams (like the transformation flow)
   - Use comments in terminal
   - Show before/after comparisons

4. **Emphasize Key Points**
   - "This is the most important part..."
   - "Notice how..."
   - "This demonstrates that..."

5. **Handle Mistakes Gracefully**
   - If something goes wrong, explain it
   - It's okay to pause and restart a section
   - Technical difficulties happen!

### Screen Layout Suggestions:

**Option 1: Terminal Only**
```
┌─────────────────────────────────────┐
│                                     │
│     Full Screen Terminal            │
│     (Large Font, High Contrast)     │
│                                     │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

**Option 2: Split Screen**
```
┌──────────────────┬──────────────────┐
│                  │                  │
│   Terminal       │   Code Editor    │
│   (Commands)     │   (Show files)   │
│                  │                  │
│                  │                  │
│                  │                  │
└──────────────────┴──────────────────┘
```

---

## QUICK DEMO SCRIPT (Copy-Paste Ready)

Save this as `demo.sh`:

```bash
#!/bin/bash

echo "╔═══════════════════════════════════════════════════╗"
echo "║   CST-405 Compiler Demonstration Script          ║"
echo "║   Authors: Christian Nshuti Manzi &              ║"
echo "║            Aime Serge Tuyishime                  ║"
echo "╚═══════════════════════════════════════════════════╝"
echo ""

sleep 2

echo "=== PART 1: Project Structure ==="
ls -la | head -20
sleep 3

echo ""
echo "=== PART 2: Building Compiler ==="
make clean
make
sleep 2

echo ""
echo "=== PART 3: Test Basic Features ==="
./compiler test_basic.src | head -50
sleep 3

echo ""
echo "=== PART 4: Test While Loop Feature ==="
./compiler test_while.src | grep -A 5 "WHILE"
sleep 3

echo ""
echo "=== PART 5: Show Generated Assembly ==="
cat output.asm | head -40
sleep 3

echo ""
echo "╔═══════════════════════════════════════════════════╗"
echo "║   Demonstration Complete!                         ║"
echo "╚═══════════════════════════════════════════════════╝"
```

Run with: `bash demo.sh`

---

## Video Checklist

Before submitting, verify your video includes:

- [ ] Introduction with your name and authors
- [ ] Project overview and structure
- [ ] Code explanation (lexer, parser, AST, semantic, IR, codegen)
- [ ] Individual task breakdown
- [ ] **Detailed AST → TAC → Assembly transformation**
- [ ] Live demonstration of building
- [ ] Live demonstration of compiling test programs
- [ ] Explanation of while loop feature in all phases
- [ ] Generated assembly code shown
- [ ] Conclusion summarizing achievements

---

**Good luck with your video! You have an excellent project to demonstrate!** 🎥🚀
