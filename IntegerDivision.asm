// IntegerDivision.asm
@R1
D=M
@DIV_ZERO
D;JEQ    // 如果 y == 0，跳转到 DIV_ZERO 处理

@R4
M=0      // R4 = 0 (标志位设为有效)
@R2
M=0      // m (商) 初始化为 0
@R3
M=0      // q (余数) 初始化为 0

@R0
D=M
@X_POSITIVE
D;JGE    // 如果 x >= 0，跳转到 X_POSITIVE 处理正数

@R0
D=-M     // x 取反
M=D
@R5
M=-1     // 记录负号

@X_POSITIVE
@R0
D=M      // D = x
@R1
D=D-M
@END_LOOP
D;JLT    // 如果 x < y，结束

@R2
M=M+1    // m++
@R0
D=M
@R1
D=D-M    // x -= y
@R0
M=D
@X_POSITIVE
0;JMP    // 继续循环

(END_LOOP)
@R3
M=D      // 余数 q = x

@R5
D=M
@NEGATIVE_RESULT
D;JLT    // 如果之前 x 是负数，调整符号

@END
0;JMP

(NEGATIVE_RESULT)
@R2
M=-M     // 商取负
@R3
M=-M     // 余数取负
@END
0;JMP

(DIV_ZERO)
@R4
M=1      // 除法无效
@END
0;JMP

(END)
@END
0;JMP
