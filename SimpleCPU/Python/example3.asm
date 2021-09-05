// Data memory example
MOV R0, #99; // Load R0 with constant 99
MOV 3, R0; // Store R0 (99) to DMEM[3]
MOV R1, #1; // Load R1 with constant 1
MOV R2, 3; // Load R2 with DMEM[3] (which is 99)
ADD R3, R2, R1; // R3 gets result of 100
MOV R3, #0;