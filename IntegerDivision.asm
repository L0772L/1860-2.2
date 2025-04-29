// IntegerDivision.asm
// Goal: Compute x / y => quotient in R2, remainder in R3
// Input: R0 = x, R1 = y
// Output: R2 = quotient, R3 = remainder, R4 = validity flag (0 = valid, 1 = invalid)
// Note: Do not modify R0 or R1

// Check if divisor (R1) is zero
@R1
D=M
@INVALID
D;JEQ          // If y == 0, division is invalid

// Save original values to temporary registers
@R0
D=M
@x_val
M=D            // Store x into x_val
@R1
D=M
@y_val
M=D            // Store y into y_val

// Compute absolute value of x, and record its sign
@x_val
D=M
@X_NEG
D;JLT          // If x < 0, jump to X_NEG

@x_abs
M=D            // x is positive, store as-is
@x_sign
M=0            // Sign flag = 0 (positive)
@CHECK_Y
0;JMP

(X_NEG)
@x_val
D=M
@x_abs
M=-D           // x is negative, store |x|
@x_sign
M=1            // Sign flag = 1 (negative)

// Compute absolute value of y, and record its sign
(CHECK_Y)
@y_val
D=M
@Y_NEG
D;JLT          // If y < 0, jump to Y_NEG

@y_abs
M=D            // y is positive
@y_sign
M=0            // Sign flag = 0
@DIVIDE
0;JMP

(Y_NEG)
@y_val
D=M
@y_abs
M=-D           // y is negative, store |y|
@y_sign
M=1            // Sign flag = 1

// Perform unsigned division: x_abs / y_abs
(DIVIDE)
@quotient
M=0            // Initialize quotient to 0
@x_abs
D=M
@remainder
M=D            // remainder = x_abs

(LOOP)
@y_abs
D=M
@remainder
D=M-D          // Subtract y_abs from remainder
@END_LOOP
D;JLT          // If remainder < y_abs, end loop

@y_abs
D=M
@remainder
M=M-D          // remainder -= y_abs
@quotient
M=M+1          // quotient += 1
@LOOP
0;JMP

// Adjust sign of quotient: if signs differ, negate
(END_LOOP)
@x_sign
D=M
@y_sign
D=D-M
@QUOTIENT_POS
D;JEQ          // If signs are same, leave positive
@quotient
M=-M           // Otherwise, negate quotient
(QUOTIENT_POS)

// Adjust sign of remainder: follows sign of x
@x_sign
D=M
@REMAINDER_POS
D;JEQ          // If x is positive, leave remainder as-is

@remainder
D=M
@REMAINDER_ZERO
D;JEQ          // If remainder is zero, skip negation

@remainder
M=-M           // Otherwise, negate remainder
(REMAINDER_ZERO)
(REMAINDER_POS)

// Store results into output registers
@quotient
D=M
@R2
M=D            // R2 = quotient

@remainder
D=M
@R3
M=D            // R3 = remainder

@R4
M=0            // R4 = 0 (valid division)
@END
0;JMP

// Handle invalid division (y = 0)
(INVALID)
@R4
M=1            // R4 = 1 (invalid)
@R2
M=0            // Clear output
@R3
M=0

(END)
@END
0;JMP          // End of program
