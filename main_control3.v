// main_control3.v
// Michael P. Lang
// 18 March 2013
// michael@mplang.net
// Main control module.

module main_control(Op,Control); 
    input [3:0] Op;
    output reg [5:0] Control;

    always @(Op) case (Op)
        // {RegDst, ALUSrc, RegWrite, ALUctl[2], ALUctl[1], ALUctl[0]}
        4'b0000: Control <= 6'b101010; // add
        4'b0001: Control <= 6'b101110; // sub 
        4'b0010: Control <= 6'b101000; // and  
        4'b0011: Control <= 6'b101001; // or    
        4'b0100: Control <= 6'b011010; // addi    
        4'b0111: Control <= 6'b101111; // slt    
    endcase
endmodule
