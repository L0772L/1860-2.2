// SumEvenIntegers.asm
// Program: Compute the sum of the first n even numbers
// Inputs: n is stored in R0
// Output: result z is stored in R1
// Special cases:
//    if n < 0, set R1 = -1
//    if overflow occurs, set R1 = -2
// Must not modify R0

// Check if n is negative
@R0
D=M
@NEGATIVE
D;JLT     // If n < 0, jump to NEGATIVE

// Initialize
@R1
M=0       // R1 = 0 (accumulator for sum)
@R2
M=0       // R2 = 0 (counter i)

(LOOP)
// Check if i > n
@R2
D=M
@R0
D=D-M
@END
D;GT      // If i > n, end loop

// Compute 2 * i
@R2
D=M
D=D+M     // D = 2 * i

// Add to sum
@R1
M=M+D     // R1 += 2 * i

// Overflow check (basic)
@R1
D=M
@OVERFLOW
D;LT      // If sum is negative after addition, overflow

// Increment i
@R2
M=M+1

// Repeat loop
@LOOP
0;JMP

(NEGATIVE)
// If n < 0, set R1 = -1
@R1
M=-1
@END
0;JMP

(OVERFLOW)
// If overflow detected, set R1 = -2
@R1
M=-2
@END
0;JMP

(END)
// End of program
@END
0;JMP
