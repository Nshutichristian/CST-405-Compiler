; CST-405 Compiler - Generated Assembly Code
; Target: x86-64 (64-bit)
; Calling Convention: System V AMD64 ABI

section .note.GNU-stack noalloc noexec nowrite progbits

section .data
    ; Data section for constants
    fmt_int: db "%d", 10, 0  ; Format string for printing integers

section .bss
    ; BSS section for uninitialized data
    x: resq 1  ; Variable: x
    y: resq 1  ; Variable: y
    z: resq 1  ; Variable: z

    ; Temporary variables
    t0: resq 1
    t1: resq 1
    t2: resq 1
    t3: resq 1
    t4: resq 1
    t5: resq 1
    t6: resq 1
    t7: resq 1
    t8: resq 1
    t9: resq 1
    t10: resq 1
    t11: resq 1
    t12: resq 1
    t13: resq 1
    t14: resq 1
    t15: resq 1
    t16: resq 1
    t17: resq 1
    t18: resq 1
    t19: resq 1
    t20: resq 1
    t21: resq 1
    t22: resq 1
    t23: resq 1
    t24: resq 1
    t25: resq 1
    t26: resq 1
    t27: resq 1
    t28: resq 1
    t29: resq 1
    t30: resq 1
    t31: resq 1
    t32: resq 1
    t33: resq 1
    t34: resq 1
    t35: resq 1
    t36: resq 1
    t37: resq 1
    t38: resq 1
    t39: resq 1
    t40: resq 1
    t41: resq 1
    t42: resq 1
    t43: resq 1
    t44: resq 1
    t45: resq 1
    t46: resq 1
    t47: resq 1
    t48: resq 1
    t49: resq 1
    t50: resq 1
    t51: resq 1
    t52: resq 1
    t53: resq 1
    t54: resq 1
    t55: resq 1
    t56: resq 1
    t57: resq 1
    t58: resq 1
    t59: resq 1
    t60: resq 1
    t61: resq 1
    t62: resq 1
    t63: resq 1
    t64: resq 1
    t65: resq 1
    t66: resq 1
    t67: resq 1
    t68: resq 1
    t69: resq 1
    t70: resq 1
    t71: resq 1
    t72: resq 1
    t73: resq 1
    t74: resq 1
    t75: resq 1
    t76: resq 1
    t77: resq 1
    t78: resq 1
    t79: resq 1
    t80: resq 1
    t81: resq 1
    t82: resq 1
    t83: resq 1
    t84: resq 1
    t85: resq 1
    t86: resq 1
    t87: resq 1
    t88: resq 1
    t89: resq 1
    t90: resq 1
    t91: resq 1
    t92: resq 1
    t93: resq 1
    t94: resq 1
    t95: resq 1
    t96: resq 1
    t97: resq 1
    t98: resq 1
    t99: resq 1

section .text
    global main
    extern printf  ; External C library function

main:
    ; Function prologue
    push rbp
    mov rbp, rsp

    ; t0 = 10
    mov rax, 10
    mov [t0], rax

    ; x = t0
    mov rax, [t0]
    mov [x], rax

    ; t1 = 20
    mov rax, 20
    mov [t1], rax

    ; y = t1
    mov rax, [t1]
    mov [y], rax

    ; t2 = x + y
    mov rax, [x]
    add rax, [y]
    mov [t2], rax

    ; z = t2
    mov rax, [t2]
    mov [z], rax

    ; print(z)
    mov rdi, fmt_int  ; Format string
    mov rsi, [z]     ; Value to print
    xor rax, rax      ; No vector registers used
    call printf

    ; print(x)
    mov rdi, fmt_int  ; Format string
    mov rsi, [x]     ; Value to print
    xor rax, rax      ; No vector registers used
    call printf

    ; print(y)
    mov rdi, fmt_int  ; Format string
    mov rsi, [y]     ; Value to print
    xor rax, rax      ; No vector registers used
    call printf


    ; Function epilogue
    mov rsp, rbp
    pop rbp
    mov rax, 0    ; Return 0 (success)
    ret
