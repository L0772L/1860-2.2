@R0
D=M         // D = x
@R1
D=D-M       // D = x - y
@LOOP_END
D;LT        // 如果 x < y，跳出循环

// 计数 m
@R2
M=0         // 初始化 m = 0
(LOOP)
@R0
D=M
@R1
D=D-M       // D = x - y
@LOOP_END
D;LT        // 如果 x < y，结束

@R0
M=D         // 更新 x = x - y
@R2
M=M+1       // m += 1
@LOOP
0;JMP       // 继续循环

(LOOP_END)
@R3
M=M         // 余数已经在 R0 中

