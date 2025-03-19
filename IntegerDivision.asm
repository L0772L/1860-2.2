// IntegerDivision.asm
// 计算商 m 和余数 q，满足 x = y * m + q，q 的符号与 x 一致

@R1
D=M
@INVALID
D;JEQ        // 如果 y == 0，跳转到无效分支

// 保存符号并取绝对值
@R0
D=M
@SIGN_X
M=D          // SIGN_X = x 的原始值
@R1
D=M
@SIGN_Y
M=D          // SIGN_Y = y 的原始值

// 取 |x| 和 |y|
@R0
D=M
@x_abs
M=D
@x_abs
D=M
@POS_X
D;JGE
@x_abs
M=-D         // x_abs = |x|

(POS_X)
@R1
D=M
@y_abs
M=D
@y_abs
D=M
@POS_Y
D;JGE
@y_abs
M=-D         // y_abs = |y|

(POS_Y)
// 初始化商和余数
@0
D=A
@R2
M=D          // R2 = 0 (商)
@x_abs
D=M
@R3
M=D          // R3 = x_abs (余数)

(LOOP)
@R3
D=M
@y_abs
D=D-M
@END_LOOP
D;JLT        // 余数 < y_abs 时结束循环

@y_abs
D=M
@R3
M=M-D        // 余数 -= y_abs
@R2
M=M+1        // 商 += 1
@LOOP
0;JMP

(END_LOOP)
// 调整商符号
@SIGN_X
D=M
@SIGN_Y
D=D*M        // D = x_sign * y_sign
@ADJUST_SIGN
D;JGE        // 同号则商为正，否则为负
@R2
M=-M

(ADJUST_SIGN)
// 调整余数符号
@SIGN_X
D=M
@R3
D;JGE
@R3
M=-M         // 余数符号与 x 一致

(END)
@R4
M=0          // R4 = 0 (有效)
@INFINITE_LOOP
0;JMP

(INVALID)
@R4
M=1          // R4 = 1 (无效)

(INFINITE_LOOP)
@INFINITE_LOOP
0;JMP        // 终止
