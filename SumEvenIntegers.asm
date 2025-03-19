// SumEvenIntegers.asm
@R0
D=M
@NEGATIVE
D;JLT    // 如果 n < 0，跳转到 NEGATIVE

@R1
M=0      // 结果初始化为 0
@I
M=0      // i = 0 (循环变量)

(LOOP)
@R0
D=M
@I
D=M-D
@END
D;JGT    // 如果 i > n，结束

@I
D=M
D=D+M    // 计算 2 * i
@R1
M=M+D    // 累加到 R1

@I
M=M+1    // i++
@LOOP
0;JMP    // 继续循环

(NEGATIVE)
@R1
M=-1
@END
0;JMP

(END)
@END
0;JMP
