// main_control.v
// Michael P. Lang
// 18 March 2013
// michael@mplang.net
// Main control module.

module main_control(Op,Control); 
    input [3:0] Op;
    output reg [9:0] Control;

    always @(Op) case (Op)
        // {RegDst, BEQ, BNE, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUctl[2], ALUctl[1], ALUctl[0]}
        4'b0000: Control <= 10'b1000001010; // add
        4'b0001: Control <= 10'b1000001110; // sub 
        4'b0010: Control <= 10'b1000001000; // and  
        4'b0011: Control <= 10'b1000001001; // or    
        4'b0100: Control <= 10'b0000011010; // addi    
        4'b0101: Control <= 10'b0001111010; // lw    
        4'b0110: Control <= 10'b0000110010; // sw    
        4'b0111: Control <= 10'b1000001111; // slt    
        4'b1000: Control <= 10'b0100000110; // beq
        4'b1001: Control <= 10'b0010000110; // bne
    endcase
endmodule
