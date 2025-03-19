// IntegerDivision.asm

// Check if divisor (R1) is zero
@R1
D=M
@INVALID
D;JEQ

// Save original values to temporary registers
@R0
D=M
@x_val
M=D      // x_val = R0
@R1
D=M
@y_val
M=D      // y_val = R1

// Compute absolute value of x and determine its sign
@x_val
D=M
@X_NEG
D;JLT    // Jump if x is negative
@x_abs
M=D      // x_abs = x (positive)
@x_sign
M=0      // x_sign = 0 (positive)
@CHECK_Y
0;JMP
(X_NEG)
@x_val
D=M
@x_abs
M=-D     // x_abs = -x (absolute value)
@x_sign
M=1      // x_sign = 1 (negative)

// Compute absolute value of y and determine its sign
(CHECK_Y)
@y_val
D=M
@Y_NEG
D;JLT    // Jump if y is negative
@y_abs
M=D      // y_abs = y (positive)
@y_sign
M=0      // y_sign = 0 (positive)
@DIVIDE
0;JMP
(Y_NEG)
@y_val
D=M
@y_abs
M=-D     // y_abs = -y (absolute value)
@y_sign
M=1      // y_sign = 1 (negative)

// Perform unsigned division (x_abs / y_abs)
(DIVIDE)
@quotient
M=0      // quotient = 0
@x_abs
D=M
@remainder
M=D      // remainder = x_abs

(LOOP)
@y_abs
D=M
@remainder
D=M-D    // D = remainder - y_abs
@END_LOOP
D;JLT    // Exit loop if remainder < y_abs
@y_abs
D=M
@remainder
M=M-D    // remainder -= y_abs
@quotient
M=M+1    // quotient += 1
@LOOP
0;JMP

// Adjust quotient's sign based on x and y signs
(END_LOOP)
@x_sign
D=M
@y_sign
D=D-M
@QUOTIENT_POS
D;JEQ     // Same sign, quotient remains positive
@quotient
M=-M     // Different signs, negate quotient
(QUOTIENT_POS)

// Adjust remainder's sign based on x's sign
@x_sign
D=M
@REMAINDER_POS
D;JEQ     // If x is positive, remainder is positive
@remainder
D=M
@REMAINDER_ZERO
D;JEQ     // Remainder is zero, no change
@remainder
M=-M     // Negate remainder if x is negative
(REMAINDER_ZERO)
(REMAINDER_POS)

// Store results and set valid flag
@quotient
D=M
@R2
M=D      // R2 = quotient
@remainder
D=M
@R3
M=D      // R3 = remainder
@R4
M=0      // R4 = 0 (valid)
@END
0;JMP

// Handle invalid division (divisor is zero)
(INVALID)
@R4
M=1      // R4 = 1 (invalid)
@R2
M=0      // R2 = 0
@R3
M=0      // R3 = 0

(END)
@END
0;JMP