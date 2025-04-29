// IntegerDivision.asm
// Compute: x = y * m + q, with x in R0, y in R1
// Outputs: R2 = m (quotient), R3 = q (remainder), R4 = 1 if invalid, 0 if valid

// Check if divisor y is zero
@R1
D=M
@INVALID
D;JEQ            // If y == 0, jump to invalid case

// Store original x in x_val
@R0
D=M
@x_val
M=D

// Store original y in y_val
@R1
D=M
@y_val
M=D

// Absolute value of x
@x_val
D=M
@X_NEG
D;JLT            // If x < 0, handle negative

@x_abs
M=D              // x is positive
@x_sign
M=0              // x_sign = 0
@CHECK_Y
0;JMP

(X_NEG)
@x_val
D=M
@x_abs
M=-D             // x_abs = -x
@x_sign
M=1              // x was negative

// Absolute value of y
(CHECK_Y)
@y_val
D=M
@Y_NEG
D;JLT            // If y < 0, handle negative

@y_abs
M=D              // y is positive
@y_sign
M=0
@DIVIDE
0;JMP

(Y_NEG)
@y_val
D=M
@y_abs
M=-D             // y_abs = -y
@y_sign
M=1

// Begin unsigned division using subtraction loop
(DIVIDE)
@quotient
M=0
@x_abs
D=M
@remainder
M=D              // remainder = x_abs

(LOOP)
@y_abs
D=M
@remainder
D=M-D
@
