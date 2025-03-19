// Square.asm
@R0
D=M      // D = x
@R1
M=0      // R1 = 0 (初始化 y=0)
@LOOP
D;JEQ    // 若 x == 0，直接结束

@R0
D=M      // D = x
@TEMP
M=D      // TEMP = x
@R1
D=M      // D = y
@MULT_LOOP
D;JEQ    // 若 y == 0，跳过乘法循环

@R1
M=M+TEMP // y += x
@MULT_LOOP
D=D-1
@MULT_LOOP
D;JGT    // 继续相加 x 次

(END)
@END
0;JMP    // 结束程序
