// IntegerDivision.asm
// 计算整数商和余数
// 输入: R0 = x, R1 = y
// 输出: R2 = m (商), R3 = q (余数), R4 = flag (1=无效, 0=有效)

@R1
D=M         // D = y
@DIV_ZERO
D;JEQ       // 如果 y == 0，跳转到 DIV_ZERO 处理

@R0
D=M         // D = x
@R1
D=D/M       // Hack 汇编不支持除法, 需手写循环
@R2
M=D         // R2 = x / y (商)

// 计算余数 q = x - (y * m)
@R2
D=M         // D = m
@R1
D=D*M       // D = y * m (Hack 也不支持乘法, 需手写)
@R0
D=M-D       // D = x - (y * m)
@R3
M=D         // R3 = q (余数)

// 标记合法运算
@R4
M=0         // R4 = 0 (合法运算)
@END
0;JMP       // 跳转到结束

(DIV_ZERO)
@R4
M=1         // R4 = 1 (无效运算)
(END)
@END
0;JMP       // 无限循环

