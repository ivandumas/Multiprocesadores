// Jump example
MOV R0, #0; // Running sum
MOV R1, #1; // Constant 1 for increment
MOV R2, #0; // Constant 0 for use in later JMPZ
label1: ADD R0, R0, R1; // Add 1 to R0
JMPZ R2, label1; // Jump to ADD instruction again
// Above is an infinite loop
// R0 should continue to increment