// IntegerDivision.asm
// Program: Perform integer division x / y
// Inputs: x is in R0, y is in R1
// Outputs: quotient in R2, remainder in R3
// R4 = 1 if division invalid (divisor = 0), else R4 = 0
// Must not modify R0 and R1

// Check if divisor y is zero
@R1
D=M
@INVALID
D;JEQ     // If y == 0, division invalid

// Copy original x and y into temporary registers
@R0
D=M
@x_val
M=D       // Save x into x_val
@R1
D=M
@y_val
M=D       // Save y into y_val

// Compute absolute value of x
@x_val
D=M
@X_POS
D;JGE
@x_val
D=M
@x_abs
M=-D      // x_abs = -x if x < 0
@x_sign
M=1       // x_sign = 1 if x negative
@CHECK_Y
0;JMP
(X_POS)
@x_val
D=M
@x_abs
M=D       // x_abs = x if x >= 0
@x_sign
M=0       // x_sign = 0 if x positive

// Compute absolute value of y
(CHECK_Y)
@y_val
D=M
@Y_POS
D;JGE
@y_val
D=M
@y_abs
M=-D      // y_abs = -y if y < 0
@y_sign
M=1       // y_sign = 1 if y negative
@DIVIDE
0;JMP
(Y_POS)
@y_val
D=M
@y_abs
M=D       // y_abs = y if y >= 0
@y_sign
M=0       // y_sign = 0 if y positive

// Perform division: x_abs / y_abs
(DIVIDE)
@quotient
M=0       // Initialize quotient = 0
@x_abs
D=M
@remainder
M=D       // Initialize remainder = x_abs

(DIV_LOOP)
// Subtract y_abs from remainder until remainder < y_abs
@y_abs
D=M
@remainder
D=M-D
@AFTER_DIV
D;LT      // Exit if remainder < y_abs
@y_abs
D=M
@remainder
M=M-D     // remainder -= y_abs
@quotient
M=M+1     // quotient += 1
@DIV_LOOP
0;JMP

(AFTER_DIV)
// Adjust sign of quotient
@x_sign
D=M
@y_sign
D=D-M
@QUOTIENT_DONE
D;JEQ     // If x and y have same sign, quotient is positive
@quotient
M=-M      // Otherwise, negate quotient
(QUOTIENT_DONE)

// Adjust sign of remainder based on x's sign
@x_sign
D=M
@REMAINDER_DONE
D;JEQ     // If x positive, remainder positive
@remainder
D=M
@ZERO_REMAINDER
D;JEQ     // If remainder = 0, skip negation
@remainder
M=-M      // Negate remainder if x negative
(ZERO_REMAINDER)
(REMAINDER_DONE)

// Store final results
@quotient
D=M
@R2
M=D       // R2 = quotient
@remainder
D=M
@R3
M=D       // R3 = remainder
@R4
M=0       // R4 = 0 (valid division)
@END
0;JMP

(INVALID)
// If division invalid (divisor = 0)
@R4
M=1       // R4 = 1
@R2
M=0
@R3
M=0

(END)
// End of program
@END
0;JMP