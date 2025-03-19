// Square.asm
// 计算 y = x^2，x 存储在 R0 中，结果存储在 R1 中

@R0
D=M          // D = R0 (x)
@R2
M=D          // R2 = x (临时存储 x)
@R1
M=0          // R1 = 0 (初始化结果为 0)

(LOOP)
@R2
D=M          // D = R2 (x)
@END
D;JEQ        // 如果 R2 == 0，跳转到 END

@R0
D=M          // D = R0 (x)
@R1
M=D+M        // R1 = R1 + x (累加 x)
@R2
M=M-1        // R2 = R2 - 1 (计数器减 1)
@LOOP
0;JMP        // 跳转到 LOOP

(END)
@END
0;JMP        // 无限循环，程序结束