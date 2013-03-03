// cpu.v
// Michael P. Lang
// 25 February 2013
// michael@mplang.net
// Main CPU module.

module MainControl(Op,Control); 
    input [3:0] Op;
    output reg [7:0] Control;

    always @(Op) case (Op)
        // {RegDst, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUctl[2], ALUctl[1], ALUctl[0]}
        4'b0000: Control <= 8'b10001010; // add
        4'b0001: Control <= 8'b10001110; // sub 
        4'b0010: Control <= 8'b10001000; // and  
        4'b0011: Control <= 8'b10001001; // or    
        4'b0100: Control <= 8'b00011010; // addi    
        4'b0101: Control <= 8'b01110010; // lw    
        4'b0110: Control <= 8'b00110010; // sw    
        4'b0111: Control <= 8'b10001111; // slt    
        4'b1000: Control <= 8'b00000110; // beq    
        4'b1001: Control <= 8'b00000110; // bne    
    endcase
endmodule

module CPU (clock, WriteData, InstrReg);
    input clock;
    output [15:0] WriteData, InstrReg;
    reg [15:0] PC;
    reg [15:0] InstrMem[0:511], DataMem[0:511];
    wire [15:0] InstrReg, SignExtend, NextPC, ReadData2, A, B, ALUOut, PCplus1, AluOrMem;
    wire [1:0] WriteReg;
    wire [3:0] op;
    wire [2:0] ALUctl;

    // Read hex data from text file into InstrMem
    initial
        $readmemh("input.hex", InstrMem);

    initial PC = 0;

    assign InstrReg = InstrMem[PC];
    assign SignExtend = {{8{InstrReg[7]}},InstrReg[7:0]}; // sign extension
    MainControl mainCtrl(InstrReg[15:12], {RegDst, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUctl[2], ALUctl[1], ALUctl[0]}); 
    register_file_4_by_16 regFile(A, ReadData2, InstrReg[11:10], InstrReg[9:8], WriteReg, WriteData, RegWrite, clock);
    alu_16_bit fetch(PCplus1, unused1, unused2, unused3, PC, 1, 3'b010),
               ex(ALUOut, unused4, Zero, unused5, A, B, ALUctl);
    
    mux_4_to_2 mux1(WriteReg, InstrReg[9:8], InstrReg[7:6], RegDst);
    mux_32_to_16 mux2(WriteData, ALUOut, DataMem[ALUOut], MemtoReg);
    mux_32_to_16 mux3(B, ReadData2, SignExtend, ALUSrc);
    assign NextPC = PCplus1;

    always @(negedge clock) begin 
        PC <= NextPC;
        if(MemWrite)
            DataMem[ALUOut] <= ReadData2;
    end
endmodule


// Test module

module test ();

reg clock;
wire [15:0] WriteData, InstrReg;

CPU test_cpu(clock, WriteData, InstrReg);

always #1 clock = ~clock;

initial begin
    $display ("time clock InstrReg       WriteData");
    $monitor ("%2d   %b     %h           %h", $time, clock, InstrReg, WriteData);
    clock = 1;
    #18 $finish;
end
endmodule
