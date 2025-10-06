# Video Recording - Quick Reference Card

**⏱️ Total Time: 10-15 minutes**

---

## 📋 QUICK OUTLINE

1. **Introduction** (1-2 min) - Who, what, overview
2. **Code Explanation** (3-4 min) - Show each phase
3. **Task Division** (2-3 min) - Who did what
4. **AST → Code Process** (3-4 min) - ⭐ MOST IMPORTANT
5. **Live Demo** (2-3 min) - Build and run
6. **Conclusion** (1 min) - Summary

---

## 🎯 MUST COVER (Required for Full Credit)

### a) ✅ How the Code Works
- Show all 6 phases: Lexer → Parser → Semantic → IR → CodeGen
- Explain each file's purpose
- Show how phases connect

### b) ✅ Individual Tasks Completed
- State what each person implemented
- Show specific code sections
- Example:
  - Person 1: Lexer, Parser, Symbol Table
  - Person 2: Semantic, IR Code, Assembly

### c) ✅ AST → Intermediate → Assembly Process
**THIS IS THE MOST IMPORTANT PART - SPEND 3-4 MINUTES HERE!**

Show the transformation step-by-step:
```
Source: while (x < 5) { print(x); }
   ↓
AST: WHILE node with CONDITION and BODY
   ↓
TAC: L0: / t1 = x < 5 / if_false goto L1 / print x / goto L0 / L1:
   ↓
Assembly: L0: / mov, cmp, setl, je, jmp / L1:
```

### d) ✅ Demonstrate Execution
- Build: `make clean && make`
- Run: `./compiler test_while.src`
- Show output at each phase
- (Optional) Assemble and run the generated code

---

## 🎬 CAMERA SETUP

### Screen Recording:
- **Font Size:** 16-18pt minimum
- **Color Scheme:** High contrast (dark background, light text)
- **Resolution:** 1080p minimum
- **Clear scrollback** before starting

### Audio:
- Test microphone first
- Speak clearly and slowly
- Pause between sections

---

## 💻 DEMO COMMANDS (Copy These)

```bash
# 1. INTRODUCTION
ls -la                    # Show project structure
ls *.c *.h *.l *.y       # Show source files

# 2. CODE EXPLANATION
head -60 scanner.l       # Show lexer
grep -A 10 "while_stmt:" parser.y    # Show parser
cat ast.h | grep "typedef enum"       # Show AST nodes

# 3. INDIVIDUAL TASKS
grep '"while"' scanner.l              # Show while token
grep -A 30 "case NODE_WHILE:" ircode.c  # Show IR generation

# 4. AST → CODE PROCESS (MOST IMPORTANT!)
cat test_while.src                    # Show source
./compiler test_while.src 2>&1 | grep -A 30 "ABSTRACT SYNTAX TREE"
./compiler test_while.src 2>&1 | grep -A 20 "THREE-ADDRESS CODE"
cat output.asm | grep -A 30 "L0:"    # Show assembly

# 5. LIVE DEMO
make clean
make
./compiler test_basic.src            # Basic test
./compiler test_while.src            # While loop test
cat output.asm                       # Show generated code
```

---

## 🗣️ KEY TALKING POINTS

### Introduction:
> "This is a complete compiler with all 6 phases, developed by Christian Nshuti Manzi and Aime Serge Tuyishime. We added while loops as our significant feature."

### Code Explanation:
> "The lexer tokenizes source code, the parser builds an AST, semantic analysis checks types, IR generates TAC, and codegen produces assembly."

### Individual Tasks:
> "[Person 1] implemented the front-end: lexer, parser, and symbol table."
> "[Person 2] implemented the back-end: semantic analysis, IR code, and assembly generation."

### AST → Code (MOST IMPORTANT):
> "The AST represents the program structure. We traverse it to generate linear TAC instructions. Each TAC instruction then becomes assembly code. Let me show you with a real example..."

[Show the transformation for while loop step by step]

### Demo:
> "Watch all phases execute successfully. Notice how the while loop goes through lexing, parsing, semantic checking, TAC generation, and assembly generation."

### Conclusion:
> "We successfully built a complete compiler with all phases functional, added a significant feature that touches every phase, and generated working assembly code."

---

## ⚠️ COMMON MISTAKES TO AVOID

❌ Don't just read code - EXPLAIN what it does
❌ Don't skip the AST → TAC → Assembly transformation
❌ Don't forget to mention BOTH authors
❌ Don't speak too fast - pause and emphasize
❌ Don't show errors without explaining them

✅ DO explain WHY, not just WHAT
✅ DO show actual output at each phase
✅ DO emphasize your significant feature
✅ DO show the complete transformation process
✅ DO demonstrate working execution

---

## 📊 TIME BREAKDOWN

```
0:00-1:30   Introduction & Project Overview
1:30-5:00   Code Explanation (all 6 phases)
5:00-7:00   Individual Task Breakdown
7:00-11:00  AST → TAC → Assembly (DETAILED!)
11:00-14:00 Live Demonstration
14:00-15:00 Conclusion
```

---

## 🎯 SCORING RUBRIC ALIGNMENT

| Requirement | What to Show | Time |
|-------------|-------------|------|
| **a) How code works** | Show all 6 phases and their interaction | 3-4 min |
| **b) Individual tasks** | Clearly state who did what, show code | 2-3 min |
| **c) AST → IR → Assembly** | ⭐ Step-by-step transformation with examples | 3-4 min |
| **d) Demonstrate execution** | Build, compile, show output | 2-3 min |

---

## 🚀 READY TO RECORD?

### Pre-Flight Checklist:
- [ ] Terminal font is large and readable
- [ ] All test files are ready (test_basic.src, test_while.src)
- [ ] Project builds successfully (`make clean && make`)
- [ ] Microphone is working
- [ ] Screen recording software is ready
- [ ] You've practiced the demo commands
- [ ] You know what to say for each section

### Open These Before Recording:
1. Terminal window
2. Text editor with these files:
   - scanner.l
   - parser.y
   - ircode.c
   - codegen.c
3. This quick reference guide

---

## 💡 PRO TIPS

1. **Rehearse Once**: Run through the demo before recording
2. **Use "Watch This"**: Direct attention to important parts
3. **Slow Down**: Speak 20% slower than normal
4. **Show Don't Tell**: Open files, point to code
5. **Pause Purposefully**: Let viewers absorb information
6. **Smile**: Even if they can't see you, it helps your voice!

---

## 🎬 RECORDING START TEMPLATE

```
"Hello, my name is [Your Name].

Today I'm demonstrating the CST-405 Complete Compiler,
developed by Christian Nshuti Manzi and Aime Serge Tuyishime.

This is a fully functional compiler implementing all six
compilation phases, with while loops as our significant feature.

Let me show you how it works..."

[BEGIN DEMONSTRATION]
```

---

## 📝 IF RECORDING GOES LONG

**If over 15 minutes, cut from:**
- Detailed explanation of every file ❌
- Reading code line by line ❌
- Showing all test programs ❌

**Never cut:**
- AST → TAC → Assembly transformation ✅
- Live demonstration ✅
- Individual task explanation ✅

---

**You've got this! Your compiler is excellent - just explain it clearly!** 🎥✨

**See VIDEO_RECORDING_GUIDE.md for full detailed script.**
