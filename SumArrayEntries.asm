// SumArrayEntries.asm
// Program: Compute the sum of all elements in an array
// Inputs: start address of array is in R0, number of elements is in R1
// Output: sum is stored in R2
// Must not modify R0 and R1

// Check if number of elements is positive
@R1
D=M
@ZERO_SUM
D;JLE    // If R1 <= 0, set sum = 0

// Initialize sum and index
@R2
M=0      // R2 = 0 (accumulator)
@R3
M=0      // R3 = 0 (index counter)

(LOOP)
// Check if index >= number of elements
@R3
D=M
@R1
D=D-M
@END
D;GE     // If index >= R1, end loop

// Compute address of current element: base address + index
@R0
D=M      // D = base address
@R3
A=D+M    // A = address of base + index
D=M      // D = value at array[index]

// Add current element to sum
@R2
M=M+D

// Increment index
@R3
M=M+1

// Repeat loop
@LOOP
0;JMP

(ZERO_SUM)
// If number of elements <= 0, set sum = 0
@R2
M=0
@END
0;JMP

(END)
// End of program
@END
0;JMP
