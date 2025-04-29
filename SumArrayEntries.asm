// SumArrayEntries.asm
// Sum all elements of an array
// R0 = base address of array
// R1 = number of elements
// R2 = result (sum of entries)
// If R1 <= 0, then R2 = 0

@R1
D=M
@ZERO_RESULT
D;JLE          // If number of entries <= 0, skip to zero result

@R2
M=0            // Initialize sum to 0
@R3
M=0            // Counter i = 0

(LOOP)
@R3
D=M
@R1
D=D-M
@END
D;JGE          // If i >= number of entries, exit loop

@R0
D=M
@R3
A=D+M          // A = base address + i
D=M            // D = value at array[i]
@R2
M=M+D          // R2 += array[i]

@R3
M=M+1          // i++
@LOOP
0;JMP          // Repeat loop

(ZERO_RESULT)
@R2
M=0            // Set result to 0

(END)
@END
0;JMP          // Halt

