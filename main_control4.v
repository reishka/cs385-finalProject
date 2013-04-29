// main_control4-2.v
// Michael P. Lang
// 17 May 2013
// michael@mplang.net
// Main control module.

module main_control(Op,Control); 
    input [3:0] Op;
    output reg [11:0] Control;

    always @(Op) case (Op)
        // {RegDst, BEQ, BNE, MemtoReg, MemWrite, ALUSrc, RegWrite, SLL, SRL, ALUctl[2], ALUctl[1], ALUctl[0]}
        4'b0000: Control <= 12'b100000100010; // add
        4'b0001: Control <= 12'b100000100110; // sub 
        4'b0010: Control <= 12'b100000100000; // and  
        4'b0011: Control <= 12'b100000100001; // or    
        4'b0100: Control <= 12'b000001100010; // addi    
        4'b0101: Control <= 12'b000111100010; // lw    
        4'b0110: Control <= 12'b000011000010; // sw    
        4'b0111: Control <= 12'b100000100111; // slt    
        4'b1000: Control <= 12'b010000000110; // beq
        4'b1001: Control <= 12'b001000000110; // bne
        4'b1010: Control <= 12'b100000110000; // sll
        4'b1011: Control <= 12'b100000101000; // srl
    endcase
endmodule
