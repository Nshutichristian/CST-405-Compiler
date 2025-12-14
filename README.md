# CST-405 Complete C Compiler

A full-featured compiler for a C-like programming language with lexical analysis, parsing, semantic analysis, optimization, and code generation for both MIPS and x86-64 architectures.

## Features

### Language Support
- Variables and arrays
- Mathematical expressions with proper precedence (+, -, *, /, %)
- Decision control structures (if, if-else, nested if)
- Loop constructs (while, for, do-while)
- Boolean/relational operations (<, >, <=, >=, ==, !=)
- Functions with parameters and return values
- Print statements

### Compiler Capabilities
- **6 Complete Compiler Phases**: Lexical analysis through code generation
- **Dual Code Generation**: MIPS (QtSpim/MARS) and x86-64 (NASM)
- **Code Optimization**: 6 optimization techniques including constant folding, dead code elimination
- **Security Analysis**: Buffer overflow, integer overflow, division by zero detection
- **Enhanced Diagnostics**: 4-level severity system with logging support
- **Performance Metrics**: Compilation time and execution time tracking
- **Comprehensive Testing**: 11+ test programs included

---

## Language Design Decisions

The compiler implements a carefully designed C-like programming language with specific design choices made for educational clarity, implementation simplicity, and practical functionality.

### 1. C-Like Syntax
**Decision**: Use familiar C-style syntax with keywords like `int`, `while`, `for`, `if`, `return`.

**Rationale**:
- **Familiarity**: Most programmers understand C syntax, reducing the learning curve
- **Educational Value**: Students can focus on compiler construction rather than learning new syntax
- **Industry Standard**: C-style syntax is prevalent in many modern languages (C++, Java, JavaScript, Go)
- **Clear Semantics**: Well-established language constructs with unambiguous meaning

### 2. Integer-Only Type System
**Decision**: Support only `int` and `void` types (no floats, doubles, strings, or user-defined types).

**Rationale**:
- **Simplicity**: Reduces complexity in semantic analysis and code generation
- **Focus on Fundamentals**: Allows concentration on core compiler concepts without type coercion complexity
- **Predictable Behavior**: Integer arithmetic has well-defined semantics and overflow behavior
- **Scope Management**: Keeps the project manageable within academic timeline constraints
- **Assembly Generation**: Integer operations map directly to simple CPU instructions in both MIPS and x86-64

**Type System Details**:
```c
int x;              // Single integer variable
int arr[10];        // Integer array
int factorial(int n) // Function with int parameters and return
void display()      // Void functions (procedures)
```

### 3. Simple I/O with `print()` Statement
**Decision**: Implement `print(expression)` instead of C's `printf()`.

**Rationale**:
- **Parsing Simplicity**: No format string parsing required
- **Type Safety**: Single expression avoids variadic argument complexity
- **Code Generation**: Maps to straightforward assembly code without format string processing
- **Educational Focus**: Demonstrates basic I/O without getting distracted by printf's complexity

### 4. Comprehensive Control Structures
**Decision**: Support all major control flow constructs: `if`, `if-else`, `while`, `for`, `do-while`.

**Rationale**:
- **Complete Language**: Provides Turing-complete control flow
- **Real-World Relevance**: These constructs appear in virtually all programs
- **Optimization Opportunities**: Loops enable demonstration of flow optimization techniques
- **Learning Objectives**: Each construct teaches different aspects of control flow translation

### 5. Array Support with Static Sizing
**Decision**: Support arrays with compile-time size specification: `int arr[10];`

**Rationale**:
- **Memory Management**: Static allocation simplifies code generation (no dynamic memory)
- **Security Analysis**: Enables compile-time bounds checking for buffer overflow detection
- **Assembly Mapping**: Direct translation to stack or data section allocation
- **Common Use Case**: Static arrays are prevalent in embedded and systems programming

### 6. Function Support with Parameters and Return Values
**Decision**: Support function declarations, definitions, calls with parameters, and return values.

**Rationale**:
- **Modularity**: Essential for real-world programming and code organization
- **Calling Conventions**: Teaches important concept of parameter passing and stack frames
- **Code Reuse**: Enables writing realistic test programs (factorial, fibonacci, etc.)
- **Compiler Complexity**: Demonstrates handling of function scope, parameter passing, and return mechanisms

### 7. Rich Set of Operators
**Decision**: Support arithmetic (`+`, `-`, `*`, `/`, `%`) and relational (`<`, `>`, `<=`, `>=`, `==`, `!=`) operators.

**Rationale**:
- **Expression Evaluation**: Demonstrates operator precedence and associativity
- **Optimization Potential**: Arithmetic operators enable constant folding and algebraic simplification
- **Conditional Logic**: Relational operators essential for control structures
- **Real Assembly Instructions**: Each operator maps to actual CPU instructions

### 8. No Pointers, No Strings, No Structures
**Decision**: Exclude pointers, string literals, and struct types from the language.

**Rationale**:
- **Scope Limitation**: Keeps project within reasonable complexity for academic timeline
- **Safety First**: Eliminates entire classes of memory safety issues
- **Clear Focus**: Allows emphasis on core compiler phases rather than complex type systems
- **Trade-off Acknowledgment**: Recognized limitation but enables deeper coverage of included features

---

## Implementation Approach Decisions

The compiler architecture reflects deliberate choices about tools, algorithms, and design patterns to create an educational yet practical compiler implementation.

### 1. Flex and Bison for Front-End
**Decision**: Use Flex (lexical analyzer generator) and Bison (parser generator) instead of hand-written scanner/parser.

**Rationale**:
- **Industry Standard**: Flex and Bison are proven tools used in production compilers (GCC, Clang)
- **Declarative Approach**: Grammar rules are more maintainable than hand-coded parsers
- **Error Handling**: Built-in error recovery mechanisms
- **Educational Value**: Teaches formal language theory (regular expressions, context-free grammars)
- **Time Efficiency**: Allows focus on other compiler phases rather than low-level parsing
- **Correctness**: Automatically generates LALR(1) parser with conflict detection

**Alternative Considered**: Hand-written recursive descent parser
- **Why Not**: More code, harder to maintain, easier to introduce bugs
- **Trade-off**: Less control over error messages, but overall better productivity

### 2. Three-Address Code (TAC) as Intermediate Representation
**Decision**: Use TAC as the IR instead of abstract syntax tree traversal for code generation.

**Rationale**:
- **Optimization-Friendly**: Linear structure makes optimization passes straightforward
- **Machine-Independent**: Abstracts away from source language and target architecture
- **Simple Format**: Each instruction has at most 3 operands (result = op1 OP op2)
- **Standard Approach**: Used in many production compilers and compiler textbooks
- **Debugging**: Easy to print and inspect during development

**TAC Example**:
```
t0 = 5
t1 = 3
t2 = t0 + t1
x = t2
```

**Alternatives Considered**:
- **Direct AST to Assembly**: Would tightly couple front-end to back-end
- **SSA Form**: More complex, provides minimal benefit for this scope
- **Stack-Based IR**: Less readable, harder to optimize

### 3. Six-Phase Compiler Architecture
**Decision**: Implement six distinct phases with clear separation of concerns.

**Rationale**:
- **Modularity**: Each phase has a single, well-defined responsibility
- **Debugging**: Errors can be isolated to specific phases
- **Educational Clarity**: Matches textbook compiler design (Dragon Book, Cooper & Torczon)
- **Incremental Development**: Phases can be built and tested independently
- **Maintenance**: Changes to one phase minimally affect others

**Phase Breakdown**:
1. **Lexical Analysis** (scanner_new.l): Tokens from characters
2. **Syntax Analysis** (parser.y): AST from tokens
3. **Semantic Analysis** (semantic.c): Type checking and symbol resolution
4. **IR Generation** (ircode.c): TAC from AST
5. **Optimization** (optimizer.c): TAC-to-TAC transformations
6. **Code Generation** (codegen.c, codegen_mips.c): Assembly from TAC

### 4. Six Optimization Techniques
**Decision**: Implement constant folding, dead code elimination, copy propagation, peephole optimization, flow optimization, and algebraic simplification.

**Rationale**:
- **Diversity**: Covers different optimization categories (local, global, peephole)
- **Practical Impact**: Measurable improvements in generated code
- **Educational Coverage**: Teaches fundamental optimization concepts
- **Manageable Scope**: Enough to demonstrate capability without overwhelming complexity

**Examples**:
```
Constant Folding:    3 + 5 → 8
Dead Code Elim:      Remove unreachable code after return
Copy Propagation:    x = y; z = x → z = y
Algebraic Simpl:     x * 1 → x, x * 0 → 0
Peephole:            Load/store elimination
Flow Optimization:   Unreachable branch removal
```

**Not Implemented**: Loop optimizations (unrolling, invariant code motion) - too complex for scope

### 5. Dual Code Generation: MIPS and x86-64
**Decision**: Support both MIPS assembly (for simulators) and x86-64 (for native execution).

**Rationale**:
- **Educational Comparison**: MIPS is RISC (simple), x86-64 is CISC (powerful)
- **Flexibility**: MIPS for classroom simulators (QtSpim, MARS), x86-64 for real execution
- **Architecture Learning**: Demonstrates register allocation strategies for different architectures
- **Modern Relevance**: x86-64 is ubiquitous, MIPS teaches fundamental concepts

**MIPS Choice**:
- Simple, regular instruction set
- Standard in computer architecture courses
- Good simulator support

**x86-64 Choice**:
- Runs natively on most development machines
- Rich instruction set with optimized operations
- Industry-relevant for systems programming

### 6. AST-Based Semantic Analysis
**Decision**: Build explicit Abstract Syntax Tree (AST) during parsing, then traverse for semantic analysis.

**Rationale**:
- **Separation of Concerns**: Syntax checking separate from semantic checking
- **Multiple Passes**: AST can be traversed multiple times for different analyses
- **Intermediate Representation**: Clean interface between parser and later phases
- **Error Recovery**: Syntax errors don't prevent semantic analysis of valid portions
- **Tool Compatibility**: Standard approach that works well with Bison's semantic actions

### 7. Symbol Table with Scope Support
**Decision**: Implement symbol table with function-level scope tracking.

**Rationale**:
- **Correctness**: Prevents name collisions between functions
- **Semantic Checking**: Enables "use before declaration" and "redeclaration" errors
- **Code Generation**: Provides variable location information for assembly generation
- **Standard Pattern**: Hash-based lookup with scope chains (standard compiler technique)

**Scope Strategy**: Hierarchical scope with global and per-function local scopes

### 8. Security Analysis as Separate Phase
**Decision**: Add dedicated security analysis phase between optimization and code generation.

**Rationale**:
- **Modern Relevance**: Security is critical in contemporary software development
- **Practical Value**: Detects buffer overflows, integer overflows, division by zero
- **Educational Impact**: Teaches defensive programming and static analysis
- **Non-Intrusive**: Separate phase doesn't complicate other phases
- **Warning System**: Helps users write safer code

**Detected Vulnerabilities**:
- Buffer overflow (array bounds)
- Integer overflow (arithmetic)
- Division by zero
- Uninitialized variables
- Infinite loops

### 9. Four-Level Diagnostic System
**Decision**: Implement NOTE, WARNING, ERROR, FATAL severity levels with file logging.

**Rationale**:
- **User Experience**: Clear communication of issues with appropriate urgency
- **Professional Quality**: Mirrors diagnostic systems in production compilers (GCC, Clang)
- **Debugging Support**: Log files enable post-compilation analysis
- **Flexibility**: `--Werror` flag allows strict mode for CI/CD pipelines
- **Categorization**: Separate diagnostic categories for different compiler phases

### 10. Performance Instrumentation
**Decision**: Include compilation time tracking and execution time measurement in generated code.

**Rationale**:
- **Optimization Validation**: Measure impact of optimization passes
- **Educational Insight**: Students can see concrete performance effects
- **Benchmarking**: Enables comparison of different compilation strategies
- **Practical Feature**: Real compilers often provide timing information (-ftime-report in GCC)

**Implementation**:
- **Compilation Time**: Clock measurement in compiler.c from start to finish
- **Execution Time**: Assembly instrumentation (x86-64 only) using C library clock() function

---

## Performance Metrics

The compiler now includes performance tracking capabilities to measure:

### 1. Compilation Time
Tracks the total time taken to compile a program through all compiler phases:
- Lexical and syntax analysis
- Semantic analysis
- Intermediate code generation
- Code optimization
- Assembly code generation

The compilation time is displayed at the end of each compilation run in the format:
```
Compilation Time: X.XXX seconds
```

### 2. Execution Time (for compiled programs)
The generated assembly code includes timing instrumentation to measure the actual execution time of the compiled program. This is automatically included in the generated code.

**Note**: Execution time measurement is available for x86-64 target only (not MIPS).

### Viewing Performance Metrics
Simply compile any program normally - performance metrics are automatically displayed:
```bash
./compiler test_basic.c
```

Output will include:
```
+============================================================+
|                   PERFORMANCE METRICS                     |
+============================================================+
|  Compilation Time:     0.023 seconds                      |
+============================================================+
```

---

## Quick Start

### Build the Compiler
```bash
make clean
make
```

### Compile a Program
```bash
# Generate x86-64 assembly (default)
./compiler test_basic.c

# Generate MIPS assembly (for QtSpim/MARS)
./compiler test_basic.c --mips

# Verbose mode with all phases displayed
./compiler test_basic.c --verbose

# Save diagnostics to log file
./compiler test_basic.c --log output.log
```

### Command-Line Options
| Option | Description |
|--------|-------------|
| `--mips` | Generate MIPS assembly instead of x86-64 |
| `--verbose` or `-v` | Enable verbose output showing all phases |
| `--log <file>` | Write diagnostics to specified log file |
| `--Werror` | Treat warnings as errors |
| `--no-warnings` | Suppress warning messages |

---

## Compiler Phases

### Phase 1: Lexical Analysis
- **File**: `scanner_new.l`
- **Tool**: Flex
- **Function**: Tokenization of source code
- **Features**: Line/column tracking, error reporting

### Phase 2: Syntax Analysis
- **File**: `parser.y`
- **Tool**: Bison
- **Function**: Parse tree and AST construction
- **Features**: Symbol table generation, grammar validation

### Phase 3: Semantic Analysis
- **Files**: `semantic.c`, `semantic.h`
- **Function**: Type checking and semantic validation
- **Features**: Variable declaration checking, scope analysis, type inference

### Phase 4: Intermediate Code Generation
- **Files**: `ircode.c`, `ircode.h`
- **Function**: Three-Address Code (TAC) generation
- **Output**: `output.ir`

### Phase 5: Code Optimization
- **Files**: `optimizer.c`, `optimizer.h`
- **Techniques**:
  1. Constant folding (3 + 5 → 8)
  2. Dead code elimination
  3. Copy propagation
  4. Peephole optimization
  5. Flow optimization
  6. Algebraic simplification (x * 1 → x)

### Phase 6: Code Generation
- **MIPS**: `codegen_mips.c`, `codegen_mips.h` → `output_mips.asm`
- **x86-64**: `codegen.c`, `codegen.h` → `output.asm`

### Additional: Security Analysis
- **Files**: `security.c`, `security.h`
- **Checks**: Buffer overflow, integer overflow, division by zero, uninitialized variables, infinite loops

### Additional: Enhanced Diagnostics
- **Files**: `diagnostics.c`, `diagnostics.h`
- **Features**: 4-level severity (NOTE, WARNING, ERROR, FATAL), logging, safe memory management

---

## Output Files

| File | Description |
|------|-------------|
| `output.asm` | x86-64 NASM assembly code (default) |
| `output_mips.asm` | MIPS assembly code (with --mips flag) |
| `output.ir` | Three-Address Code (intermediate representation) |
| `*.log` | Diagnostic log file (with --log flag) |

---

## Testing

### Basic Test
```bash
./compiler test_basic.c
```

### Test All Features
```bash
# Test loops
./compiler test_loops.c

# Test conditionals
./compiler test_if_else.c

# Test arrays
./compiler test_arrays.c

# Test functions
./compiler test_functions.c

# Test security analysis
./compiler test_security.c

# Test comprehensive (all features)
./compiler test_comprehensive.c --verbose
```

### Test MIPS Code Generation
```bash
./compiler test_basic.c --mips
cat output_mips.asm
```

### Verify Optimization
```bash
./compiler test_basic.c --verbose 2>&1 | grep "optimization"
```

---

## Test Programs Included

- `test_basic.c` - Basic arithmetic and variables
- `test_loops.c` - While, for, do-while loops
- `test_if_else.c` - Conditional statements
- `test_arrays.c` - Array operations
- `test_functions.c` - Function declarations and calls
- `test_nested_loops.c` - Nested loop structures
- `test_order_of_operations.c` - Expression precedence
- `test_comprehensive.c` - All features combined
- `test_security.c` - Security vulnerability detection
- `test_for.c` - For loop specific tests
- `test_do_while.c` - Do-while loop tests

---

## Language Example

```c
int factorial(int n) {
    int result;
    int i;
    result = 1;
    i = 1;

    while (i <= n) {
        result = result * i;
        i = i + 1;
    }

    return result;
}

int main() {
    int x;
    x = 5;
    print(factorial(x));  // Output: 120
    return 0;
}
```

---

## Building and Running Programs

### For x86-64 (Linux/macOS)
```bash
# Compile to assembly
./compiler program.c

# Assemble (requires NASM)
nasm -f elf64 output.asm -o output.o

# Link (requires GCC)
gcc output.o -o program -no-pie

# Run
./program
```

### For MIPS (QtSpim/MARS Simulator)
```bash
# Compile to MIPS assembly
./compiler program.c --mips

# Open output_mips.asm in QtSpim or MARS
# Run in the simulator
```

---

## Practical Demonstration: Compiler in Action

This section demonstrates the compiler working through a complete example, showing all phases and explaining the compilation process.

### Example Program
Let's compile a simple factorial calculator (`test_basic.c`):

```c
int factorial(int n) {
    int result;
    int i;
    result = 1;
    i = 1;

    while (i <= n) {
        result = result * i;
        i = i + 1;
    }

    return result;
}

int main() {
    int x;
    x = 5;
    print(factorial(x));
    return 0;
}
```

### Step-by-Step Compilation Process

#### Step 1: Run the Compiler
```bash
./compiler test_basic.c --verbose
```

#### Step 2: Lexical Analysis (Phase 1)
The scanner (Flex) tokenizes the input:
```
INT -> "int"
ID -> "factorial"
LPAREN -> "("
INT -> "int"
ID -> "n"
RPAREN -> ")"
LBRACE -> "{"
...
```

**What's Happening**: The source code is converted into a stream of tokens. Each keyword, identifier, operator, and punctuation mark becomes a token with its type and value.

#### Step 3: Syntax Analysis (Phase 2)
The parser (Bison) builds an Abstract Syntax Tree (AST):
```
PROGRAM
├── FUNCTION_DEFINITION (factorial)
│   ├── PARAM_LIST
│   │   └── PARAM (n, int)
│   └── STATEMENT_LIST
│       ├── VAR_DECLARATION (result, int)
│       ├── VAR_DECLARATION (i, int)
│       ├── ASSIGNMENT (result = 1)
│       ├── ASSIGNMENT (i = 1)
│       ├── WHILE_LOOP
│       │   ├── CONDITION (i <= n)
│       │   └── STATEMENT_LIST
│       │       ├── ASSIGNMENT (result = result * i)
│       │       └── ASSIGNMENT (i = i + 1)
│       └── RETURN (result)
└── FUNCTION_DEFINITION (main)
    └── ...
```

**What's Happening**: The token stream is parsed according to the grammar rules. The compiler verifies the syntax is correct and constructs a hierarchical representation (AST).

#### Step 4: Semantic Analysis (Phase 3)
The semantic analyzer checks:
- ✓ Variable `n` is declared (function parameter)
- ✓ Variables `result` and `i` are declared before use
- ✓ Types match in expressions (`result * i` - both int)
- ✓ Function `factorial` returns int as declared
- ✓ No division by zero detected

**Output**:
```
+============================================================+
| PHASE 3: SEMANTIC ANALYSIS                                 |
+============================================================+
[OK] SUCCESS: No semantic errors detected
```

**What's Happening**: The compiler verifies semantic correctness - are variables declared? Do types match? Are functions used correctly?

#### Step 5: Intermediate Code Generation (Phase 4)
Three-Address Code (TAC) is generated:

```
FUNCTION_LABEL factorial:
    result = 1
    i = 1
L0:
    t0 = i <= n
    if_false t0 goto L1
    t1 = result * i
    result = t1
    t2 = i + 1
    i = t2
    goto L0
L1:
    return result
FUNCTION_LABEL main:
    x = 5
    param x
    t3 = call factorial, 1
    print t3
    return 0
```

**Output**:
```
+============================================================+
| PHASE 4: INTERMEDIATE CODE GENERATION                      |
+============================================================+
Generated 18 TAC instructions
[OK] Intermediate code saved to: output.ir
```

**What's Happening**: The AST is linearized into a simple, three-address instruction format. This intermediate representation is machine-independent and easy to optimize.

#### Step 6: Code Optimization (Phase 5)
The optimizer applies transformations:

**Before Optimization**:
```
t0 = 1
result = t0    # Copy propagation opportunity
t1 = 3 + 5     # Constant folding opportunity
```

**After Optimization**:
```
result = 1     # Copy propagated
t1 = 8         # Constants folded
```

**Output**:
```
+============================================================+
| PHASE 5: CODE OPTIMIZATION                                 |
+============================================================+
[OPTIMIZER] Constant folding: 3 optimizations
[OPTIMIZER] Dead code elimination: 0 optimizations
[OPTIMIZER] Copy propagation: 2 optimizations
[OPTIMIZER] Algebraic simplification: 1 optimization
[OPTIMIZER] Total optimizations: 6
```

**What's Happening**: The TAC is improved through various optimization techniques. Constants are evaluated at compile-time, redundant operations are removed, and code is simplified.

#### Step 7: Security Analysis (Phase 5.5)
Security checks are performed:
```
+============================================================+
| PHASE 5.5: SECURITY ANALYSIS                               |
+============================================================+
[SECURITY] Checking for buffer overflows...
[SECURITY] Checking for integer overflows...
[SECURITY] Checking for division by zero...
[SECURITY] Checking for uninitialized variables...
✓ No security issues detected!
```

**What's Happening**: The compiler performs static analysis to detect common vulnerabilities like buffer overflows, integer overflows, and division by zero.

#### Step 8: Code Generation (Phase 6)
Assembly code is generated for x86-64:

```nasm
section .data
    fmt: db "%d", 10, 0

section .text
    global main
    extern printf

factorial:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov QWORD [rbp-8], 1     ; result = 1
    mov QWORD [rbp-16], 1    ; i = 1

.L0:
    mov rax, [rbp-16]        ; i
    cmp rax, [rbp+16]        ; compare with n
    jg .L1                    ; if i > n, exit loop

    mov rax, [rbp-8]         ; result
    imul rax, [rbp-16]       ; result * i
    mov [rbp-8], rax         ; result = result * i

    mov rax, [rbp-16]        ; i
    add rax, 1               ; i + 1
    mov [rbp-16], rax        ; i = i + 1

    jmp .L0                   ; loop back

.L1:
    mov rax, [rbp-8]         ; return result
    mov rsp, rbp
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov QWORD [rbp-8], 5     ; x = 5
    mov rdi, [rbp-8]         ; parameter
    call factorial

    mov rdi, fmt
    mov rsi, rax
    xor rax, rax
    call printf

    xor rax, rax
    mov rsp, rbp
    pop rbp
    ret
```

**Output**:
```
+============================================================+
| PHASE 6: ASSEMBLY CODE GENERATION                          |
+============================================================+
[CODEGEN] Generating x86-64 assembly...
[CODEGEN] Function: factorial
[CODEGEN] Function: main
[CODEGEN] Assembly generation complete

[OK] Assembly code written to: output.asm
```

**What's Happening**: The optimized TAC is translated into target assembly code. Register allocation, stack frame management, and calling conventions are handled automatically.

### Performance Metrics
After compilation completes, performance metrics are displayed:

```
+============================================================+
|                   COMPILATION SUMMARY                     |
+============================================================+
|  Status:           [OK] SUCCESS                           |
|  Lexical errors:   0                                      |
|  Syntax errors:    0                                      |
|  Semantic errors:  0                                      |
|  Optimization:     Enabled (6 optimizations applied)      |
|  Security issues:  0                                      |
|  Code generated:   Yes                                    |
+============================================================+
|                   PERFORMANCE METRICS                     |
+============================================================+
|  Compilation Time:     0.023 seconds                      |
+============================================================+

[OK] Compilation successful!
```

### Running the Generated Code

#### Assemble and Link (x86-64)
```bash
nasm -f elf64 output.asm -o output.o
gcc output.o -o program -no-pie
./program
```

**Output**:
```
120
Execution Time: 47 clock ticks
```

**Result**: The program correctly computes 5! = 120 and displays execution time.

### Testing with MIPS
```bash
./compiler test_basic.c --mips
# Open output_mips.asm in QtSpim or MARS simulator
```

The same program is compiled to MIPS assembly for educational simulators.

### Automated Testing Script
Run the comprehensive test script:

```bash
./test_features.sh
```

This demonstrates:
- Loop support (while, for, do-while)
- Order of operations (operator precedence)
- All compiler phases working together
- Performance metrics for multiple test programs

---

## Project Structure

```
CST-405-PROJECTS/
├── compiler.c              # Main compiler driver
├── scanner_new.l           # Lexical analyzer (Flex)
├── parser.y                # Syntax analyzer (Bison)
├── ast.c / ast.h           # Abstract Syntax Tree
├── semantic.c / semantic.h # Semantic analysis
├── ircode.c / ircode.h     # IR code generation
├── optimizer.c / optimizer.h     # Code optimizer
├── codegen.c / codegen.h   # x86-64 code generator
├── codegen_mips.c / codegen_mips.h  # MIPS code generator
├── diagnostics.c / diagnostics.h    # Diagnostics system
├── security.c / security.h # Security analysis
├── Makefile                # Build system
├── test_*.c                # Test programs (11 files)
└── README.md               # This file
```

---

## Requirements

- **GCC** - C compiler
- **Flex** - Lexical analyzer generator
- **Bison** - Parser generator
- **Make** - Build automation
- **NASM** (optional) - For assembling x86-64 output
- **QtSpim/MARS** (optional) - For running MIPS output

### Installation (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install gcc flex bison make nasm
```

### Installation (macOS)
```bash
brew install gcc flex bison make nasm
```

---

## Makefile Commands

```bash
make          # Build the compiler
make clean    # Remove generated files
make info     # Show compiler information
make help     # Show available commands
```

---

## Compilation Examples

### Example 1: Basic Compilation
```bash
./compiler test_basic.c
# Creates: output.asm, output.ir
```

### Example 2: MIPS with Verbose Output
```bash
./compiler test_loops.c --mips --verbose
# Shows all phases, creates: output_mips.asm, output.ir
```

### Example 3: Production Mode (Warnings as Errors)
```bash
./compiler program.c --Werror
# Strict error checking
```

### Example 4: Full Logging
```bash
./compiler test_comprehensive.c --verbose --log compile.log
# All diagnostics saved to compile.log
```

---

## Expected Output

### Successful Compilation
```
+============================================================+
|           CST-405 COMPLETE COMPILER SYSTEM                 |
+============================================================+

Input file: test_basic.c
Output file: output.asm
Target: x86-64 (NASM)

+============================================================+
| PHASE 1 & 2: LEXICAL AND SYNTAX ANALYSIS                  |
+============================================================+
[OK] Lexical analysis complete
[OK] Syntax analysis complete
[OK] Abstract Syntax Tree (AST) constructed

+============================================================+
| PHASE 3: SEMANTIC ANALYSIS                                 |
+============================================================+
[OK] SUCCESS: No semantic errors detected

+============================================================+
| PHASE 4: INTERMEDIATE CODE GENERATION                      |
+============================================================+
Generated 25 TAC instructions
[OK] Intermediate code saved to: output.ir

+============================================================+
| PHASE 5: CODE OPTIMIZATION                                 |
+============================================================+
[OPTIMIZER] Total optimizations: 12

+============================================================+
| PHASE 5.5: SECURITY ANALYSIS                               |
+============================================================+
✓ No security issues detected!

+============================================================+
| PHASE 6: ASSEMBLY CODE GENERATION                          |
+============================================================+
[CODEGEN] Assembly generation complete

+============================================================+
|                   COMPILATION SUMMARY                     |
+============================================================+
|  Status:           [OK] SUCCESS                           |
|  Lexical errors:   0                                      |
|  Syntax errors:    0                                      |
|  Semantic errors:  0                                      |
|  Optimization:     Enabled                                |
|  Code generated:   Yes                                    |
+============================================================+

[OK] Compilation successful!
[OK] Assembly code written to: output.asm
```

---

## Error Reporting

The compiler provides detailed error messages with line and column information:

```
[semantic:10:5] error: Variable 'x' used before declaration
[security:15:3] warning: Array 'arr' access with index 10 is out of bounds [0..9]
[semantic:20:8] error: Division by zero detected
```

---

## Security Analysis Features

The compiler detects potential security vulnerabilities:

1. **Buffer Overflow**: Array access out of bounds
2. **Integer Overflow**: Arithmetic operations that may overflow
3. **Division by Zero**: Division or modulo by constant zero
4. **Uninitialized Variables**: Variables used before assignment
5. **Infinite Loops**: Loops with constant true conditions

Example security report:
```
╔════════════════════════════════════════════════════╗
║           SECURITY ANALYSIS REPORT                ║
╠════════════════════════════════════════════════════╣
║ Buffer Overflow Risks:      1                     ║
║ Integer Overflow Risks:     0                     ║
║ Division by Zero Risks:     0                     ║
║ Unsafe Array Accesses:      0                     ║
║ Infinite Loop Risks:        0                     ║
╠════════════════════════════════════════════════════╣
║ Total Security Issues:      1                     ║
╚════════════════════════════════════════════════════╝
```

---

## Troubleshooting

### Issue: `compiler: command not found`
**Solution**: Build the compiler first
```bash
make
```

### Issue: `flex: not found` or `bison: not found`
**Solution**: Install flex and bison
```bash
# Ubuntu/Debian
sudo apt-get install flex bison

# macOS
brew install flex bison
```

### Issue: No output files generated
**Solution**: Check for compilation errors
```bash
./compiler test_basic.c --verbose
```

---

## Course Information

**Course**: CST-405 Compiler Design
**Project**: Complete C Compiler Implementation
**Features**: 6 compiler phases, dual code generation, optimization, security analysis

---

## License

Educational project for CST-405 Compiler Design course.

---

## Contact

For issues or questions related to this compiler project, please refer to the course materials or contact the instructor.
