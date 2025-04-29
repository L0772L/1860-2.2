// SumEvenIntegers.asm
// Compute z = sum of first n even numbers (0 + 2 + 4 + ... + 2n)
// Input: n in R0
// Output: result in R1
// If n < 0, R1 = -1

@R0
D=M
@NEGATIVE
D;JLT          // If n < 0, go to NEGATIVE

@R1
M=0            // Initialize sum R1 = 0
@I
M=0            // Initialize loop counter i = 0

(LOOP)
@R0
D=M
@I
D=M-D
@END
D;JGT          // If i > n, end the loop

@I
D=M
D=D+M          // Compute 2 * i
@R1
M=M+D          // Accumulate result: R1 += 2 * i

@I
M=M+1          // i++
@LOOP
0;JMP          // Repeat the loop

(NEGATIVE)
@R1
M=-1           // If n is negative, set result to -1
@END
0;JMP

(END)
@END
0;JMP          // Infinite loop to halt

