---
layout: post
title: "Writing portable assembly code"
date:   2025-01-12 19:30:00 +0900
categories: assembly
---

### NASM
NASM(Netwide Assembler) is cross-platform x86 assembler that supports OS-specific directives and various output file formats such as elf(Linux), mach-O(macOS). This post aims to writing simple Linux, macOS portable assembly code NASM can assemble.

### ABI
Output file(machine code) must be compatible with current environment to be executed. x86 machine code cannot run on ARM CPU directly. ELF file is not executable on macOS that support mach-O. Many elements including calling convention, CPU architecture, file format determine the ABI, interface between software and combination of OS and hardware. 

#### Common
- Calling convention
[osdev - System V ABI](https://wiki.osdev.org/System_V_ABI)
Calling convention of the ABI is one of the common feature shared by Linux and macOS. Calling convention defines rules for invoking a function, such as where function parameters and return value are stored.

#### Linux
[system call table](https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl)
- system call
)
Each OS has its own method for calling system calls. In Linux, follow the calling convention and set `rax` to system call index.
```
    mov rax, 0  ; index 0: read system call
    syscall
```
After system call returns successfully, `rax` have return values like number of bytes.
If there is an error, `rax` have *negated* error number. Negate the value of `rax` again and store it in `errno` to properly handle error.

- global symbol
In NASM, `global` directive exports a symbol so that external file can use the symbol. `extern` imports a symbol from other file.
```
    global  main
    extern  printf
```

- errno
We can get error information of system call through `errno`.
```
// errno.h
#define errno (*__errno_location())
```
Indeed `errno` is a macro for indirection of an address returned by `__errno_location`. Because Linux and macOS have different symbol for the function returning the address of `errno`, Writing NASM macro for `errno` can help writing portable assembly.
```
    call    __errno_location
```
This will return the address of the `errno` in `rax`.

#### macOS
[system call master file](https://github.com/opensource-apple/xnu/blob/master/bsd/kern/syscalls.master)
[system call classes](https://github.com/apple-oss-distributions/xnu/blob/main/osfmk/mach/i386/syscall_sw.h)
- system call
There are not much differences compared to Linux except `rax` value.
macOS has different table and index: Index for read system call is 3.
macOS has system call class that is consists of mach, Unix, etc.
[24,31] bits are used to represent the class.
```
    mov rax, 0x2000003
    ; class 2: Unix class
    ; index 3: read system call
    ; 0x2000003 = (2 << 24) | 3 = (CLASS << 24) | INDEX
    syscall
```
System call error is indicated by carry bit. If carry bit is not set, it is safe to return. If not, store the value of `rax` to `errno`. Linux uses 32th bit and macOS uses carry bit to notify the system call error.

- global symbol
In macOS, all the global symbols are prepended with an underscore.
This is done by the compiler automatically, but we must set it manually while writing assembly.
```
    global  _main
    extern  _printf
```

- errno
macOS system library uses different symbol for `errno` compared to Linux.
```
// sys/errno.h
#define errno (*__error())
```
Note there are three underscores because `__error` symbol in C source code is before compile.
```
    call    ___errno
```

___

### Position Independent Executable
Compiler generates *PIE* file as default because it enables ASLR(Address Space Layout Randomization). Loaded program image will have randomized addresses everytime it executed so that addresses cannot be predicted easily. Normaly libc is position independent to prevent attacks. Calling standard functions without considering *PIE* in assembly will cause link error.
```
# linker error
relocation R_X86_64_32 against `.rodata' can not be used when making a *PIE* object; recompile with `-fPIE`
```

#### Linux
Calling `printf` or functions from PIE library requires `WRT` operator. Operands for the `WRT` are listed in NASM documentation.
```
    extern printf
    ...
    call printf WRT ..plt
    ...
```
Operand is `..plt`, procedure linkage table, because printf is a procedure name.
[NASM - PIC](https://www.nasm.us/xdoc/2.16.03/html/nasmdoc8.html#section-8.9.3)

#### macOS
NASM will generate valid output without using `WRT`.
```
    extern _printf
    ...
    call _printf
    ...
```
[Apple Documentation - PIC](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/MachOTopics/1-Articles/dynamic_code.html#//apple_ref/doc/uid/TP40002528-SW1)

### Using NASM macro
Macro is useful when writing assembly code clearly because there are many OS specific directives and conventions. Below are examples from NASM documentation.
- [symbol name](https://www.nasm.us/xdoc/2.16.03/html/nasmdoc7.html#section-7.10)
- [multi-line macro](https://www.nasm.us/xdoc/2.16.03/html/nasmdoc4.html#section-4.5)
