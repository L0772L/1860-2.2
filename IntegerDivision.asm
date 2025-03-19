// IntegerDivision.asm
// 计算整数除法的商和余数
// x 存储在 R0 中，y 存储在 R1 中
// 商 m 存储在 R2 中，余数 q 存储在 R3 中
// R4 是标志位，1 表示除法无效，0 表示有效

@R1
D=M          // D = R1 (y)
@INVALID
D;JEQ        // 如果 y == 0，跳转到 INVALID

@R0
D=M          // D = R0 (x)
@R2
M=0          // R2 = 0 (初始化商为 0)
@R3
M=D          // R3 = x (初始化余数为 x)

@R0
D=M          // D = R0 (x)
@POSITIVE_X
D;JGE        // 如果 x >= 0，跳转到 POSITIVE_X

// 处理 x < 0 的情况
@R0
D=M          // D = R0 (x)
@R3
M=-D         // R3 = -x (取绝对值)
@R1
D=M          // D = R1 (y)
@POSITIVE_Y
D;JGE        // 如果 y >= 0，跳转到 POSITIVE_Y

// 处理 y < 0 的情况
@R1
D=M          // D = R1 (y)
@R1
M=-D         // R1 = -y (取绝对值)

(POSITIVE_Y)
(LOOP)
@R3
D=M          // D = R3 (余数)
@R1
D=D-M        // D = R3 - R1 (余数 - y)
@END
D;JLT        // 如果余数 < y，跳转到 END

@R1
D=M          // D = R1 (y)
@R3
M=M-D        // R3 = R3 - y (余数减去 y)
@R2
M=M+1        // R2 = R2 + 1 (商加 1)
@LOOP
0;JMP        // 跳转到 LOOP

(POSITIVE_X)
@R1
D=M          // D = R1 (y)
@POSITIVE_Y
D;JGE        // 如果 y >= 0，跳转到 POSITIVE_Y

// 处理 y < 0 的情况
@R1
D=M          // D = R1 (y)
@R1
M=-D         // R1 = -y (取绝对值)

(POSITIVE_Y)
(LOOP)
@R3
D=M          // D = R3 (余数)
@R1
D=D-M        // D = R3 - R1 (余数 - y)
@END
D;JLT        // 如果余数 < y，跳转到 END

@R1
D=M          // D = R1 (y)
@R3
M=M-D        // R3 = R3 - y (余数减去 y)
@R2
M=M+1        // R2 = R2 + 1 (商加 1)
@LOOP
0;JMP        // 跳转到 LOOP

(INVALID)
@R4
M=1          // R4 = 1 (设置标志位为 1，表示除法无效)
@END
0;JMP        // 跳转到 END

(END)
@R0
D=M          // D = R0 (x)
@R3
D=M          // D = R3 (余数)
@R0
D=D-M        // D = R3 - x
@END
0;JMP        // 无限循环，程序结束
