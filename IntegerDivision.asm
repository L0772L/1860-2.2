// IntegerDivision.asm
// 计算商 m 和余数 q，满足 x = y * m + q，q 的符号与 x 一致

@R1
D=M
@INVALID
D;JEQ        // 如果 y == 0，跳转到无效分支

// 保存原始值并取绝对值
@R0
D=M
@SIGN_X
M=D          // SIGN_X = x 的符号（原始值）
@R0
D=M
@x_abs
M=D          // x_abs = x
@x_abs
D=M
@POS_X
D;JGE        // 如果 x >= 0，跳过取反
@x_abs
M=-D         // x_abs = |x|

(POS_X)
@R1
D=M
@SIGN_Y
M=D          // SIGN_Y = y 的符号
@R1
D=M
@y_abs
M=D          // y_abs = y
@y_abs
D=M
@POS_Y
D;JGE        // 如果 y >= 0，跳过取反
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
D=D-M        // D = 余数 - y_abs
@END_LOOP
D;JLT        // 余数 < y_abs → 结束循环

// 余数 >= y_abs → 继续减
@y_abs
D=M
@R3
M=M-D        // 余数 -= y_abs
@R2
M=M+1        // 商 += 1
@LOOP
0;JMP

(END_LOOP)
// 调整商符号：若 x 和 y 符号不同，商为负
@SIGN_X
D=M
@SIGN_Y
D=D*M
@ADJUST_SIGN
D;JGE        // 同号 → 不需要调整
@R2
M=-M

(ADJUST_SIGN)
// 调整余数符号：与 x 一致
@SIGN_X
D=M
@R3
M=D          // 余数 = x 的符号 * |余数|
@R3
D=M
@POS_Q
D;JGE        // 如果 x 非负，跳过取反
@R3
M=-M         // 余数取反（因为 x 为负）

(POS_Q)
// 处理余数为负的情况（确保余数符号与 x 一致）
@R3
D=M
@y_abs
D=D+M        // D = q + y_abs（若 q < 0，可能需要调整）
@FINAL_CHECK
D;JGE        // 如果 q >= 0，无需调整

// 若 q < 0，则 q += y_abs，商 -= 1
@y_abs
D=M
@R3
M=M+D        // q += y_abs
@R2
M=M-1        // m -= 1

(FINAL_CHECK)
@R4
M=0          // R4 = 0（有效）
@END
0;JMP

(INVALID)
@R4
M=1          // R4 = 1（无效）

(END)
@END
0;JMP        // 程序终止