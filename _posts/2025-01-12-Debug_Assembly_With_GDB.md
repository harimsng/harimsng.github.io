---
layout: post
title: "Debug assembly code with GDB"
date:   2025-01-12 19:30:00 +0900
categories: gdb assembly
---

## GDB (GNU Debugger)
A debugger like gdb and lldb is useful when debugging a program. An user can control execution of a program, see current state of a program. I usually compile a C/C++ program with debug option for debugging. Compiler debug option will generate a executable file with additional informations so that debugger can give more informations to user. If such informations are not included in the executable, user may need to debug it with register values and assembly codes.

## GDB commands

### assembly view
`layout asm` command enables assembly view. If the executable has debug information, use `layout src` to enable source view.


![image](/assets/images/gdb_asm.png)

### register values
`layout reg` command enables register view. What registers will be displayed in the view varies by window size.


![image](/assets/images/gdb_reg.png)

### next instruction
Use `nexti` or `ni` to execute one instruction and move cursor to the next instruction. Cursor points to an assembly line that located at the value of `RIP`, called instruction pointer or program counter.
##### Before
![image](/assets/images/gdb_inst.png)


`RIP = 0x5555555552c7`

##### After
![image](/assets/images/gdb_ni.png)


`RIP = 0x5555555552cc`, cursor moved to next instruction and some registers have changed as a result of a subroutine call.

### step into subroutine calls
If the next instruction is a subroutine call, `stepi` and `si` commands will move the cursor into the call. 
##### After
![image](/assets/images/gdb_si.png)


`RIP = 0x555555555150`, cursor moved to an entry of procedure linkage table, `malloc@plt`.

