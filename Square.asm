// Square.asm
@R0
D=M      // D = x
@R1
M=0      // R1 = 0 (初始化 y=0)

@R0
D=M
@NEGATIVE
D;JLT    // 如果 x < 0，跳转到 NEGATIVE 处理负数

@I
M=D      // I = x (循环变量)
@LOOP
D=M
@END
D;JEQ    // 如果 I == 0，结束

@R0
D=M
@R1
M=M+D    // R1 += x (重复 x 次累加)

@I
M=M-1    // I--
@LOOP
0;JMP    // 继续循环

(END)
@END
0;JMP    // 结束程序

(NEGATIVE)
@R0
D=M
D=-D     // 取 x 的绝对值
@I
M=D      // I = abs(x)

@LOOP_NEG
D=M
@END
D;JEQ    // 如果 I == 0，结束

@R0
D=M
D=-D
@R1
M=M+D    // R1 += (-x)，负数相乘仍为正数

@I
M=M-1    // I--
@LOOP_NEG
0;JMP    // 继续循环
