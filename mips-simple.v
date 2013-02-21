// module reg_file(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, ReadData1, ReadData2, clock);
//     input [1:0] ReadRegister1, ReadRegister2, WriteRegister;
//     input [15:0] WriteData;
//     input RegWrite, clock;
//     output [15:0] ReadData1, ReadData2;
// 
//     reg [15:0] Regs[0:3];
// 
//     initial Regs[0] = 0;  // $0 = constant 0
// 
//     assign ReadData1 = Regs[ReadRegister1];
//     assign ReadData2 = Regs[ReadRegister2];
// 
//     always @(negedge clock)
//         if(RegWrite == 1 & WriteRegister != 0) // $0 is constant
//             Regs[WriteRegister] <= WriteData;
// endmodule

module MainControl (Op,Control); 
    input [3:0] Op;
    output reg [9:0] Control;

    always @(Op) case (Op)
        4'b0000: Control <= 10'b1000001010; // add
        4'b0001: Control <= 10'b1000001110; // sub    
        4'b0010: Control <= 10'b1000001000; // and     
        4'b0011: Control <= 10'b1000001001; // or    
        4'b0100: Control <= 10'b0000011010; // addi    
        4'b0101: Control <= 10'b0001110010; // lw    
        4'b0110: Control <= 10'b0000110010; // sw    
        4'b0111: Control <= 10'b1000001111; // slt    
        4'b1000: Control <= 10'b0100000110; // beq    
        4'b1001: Control <= 10'b0010000110; // bne    
    endcase
endmodule

module CPU (clock, WriteData, InstrReg);
    input clock;
    output [15:0] WriteData, InstrReg;
    reg[15:0] PC, InstrMem[0:511], DataMem[0:511];
    wire [15:0] InstrReg, SignExtend, NextPC, ReadData2, A, B, ALUOut, PCplus2, Target;
    wire [1:0] WriteRegister;
    wire [3:0] op;
    wire [2:0] ALUctl;

    initial begin 
        InstrMem[0] = 16'h410f;     // addi $1, $0, 15
        InstrMem[2] = 16'h4207;     // addi $2, $0, 7
        // InstrMem[2] = 16'h42f9;     // addi $2, $0, -7
        InstrMem[4] = 16'h26c0;     // and $3, $1, $2
        InstrMem[6] = 16'h1780;     // sub  $2, $1, $3
        InstrMem[8] = 16'h3b80; // or   $2, $2, $3
        InstrMem[10] = 16'h7e40; // slt  $1, $3, $2
        InstrMem[12] = 16'h7b40; // slt  $1, $2, $3

        // Data
        DataMem [0] = 16'h5; // switch the cells and see how the simulation output changes
        DataMem [2] = 16'h7;
    end

    initial PC = 0;

    assign InstrReg = InstrMem[PC];
    assign SignExtend = {{8{InstrReg[7]}},InstrReg[7:0]}; // sign extension
    MainControl MainCtr(InstrReg[15:12], {RegDst, BEQ, BNE, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUctl[2], ALUctl[1], ALUctl[0]}); 
    register_file_4_by_16 rf(A, ReadData2, InstrReg[11:10], InstrReg[9:8], WriteRegister, WriteData, RegWrite, clock);
    // reg_file rf(InstrReg[11:10], InstrReg[9:8], WriteRegister, WriteData, RegWrite, A, ReadData2, clock);
    alu_16_bit fetch(PCplus2, unused1, unused2, unused3, PC, 2, 3'b010),
               ex(ALUOut, unused4, Zero, unused5, A, B, ALUctl),
               branch(Target, unused6, unused7, unused8, SignExtend<<2, PCplus2, 3'b010);
    
    assign WriteRegister = (RegDst) ? InstrReg[7:6] : InstrReg[9:8]; // RegDst Mux
    assign WriteData = (MemtoReg) ? DataMem[ALUOut] : ALUOut; // MemtoReg Mux
    assign B  = (ALUSrc) ? SignExtend : ReadData2; // ALUSrc Mux 
    assign NextPC = (BEQ && Zero || BNE && ~Zero) ? Target : PCplus2; // Branch Mux

    always @(negedge clock) begin 
        PC <= NextPC;
        if(MemWrite)
            DataMem[ALUOut] <= ReadData2;
    end
endmodule


// Test module

module test ();

reg clock;
wire [15:0] WriteData,InstrReg;

CPU test_cpu(clock,WriteData,InstrReg);

always #1 clock = ~clock;

initial begin
    $display ("time clock InstrReg       WriteData");
    $monitor ("%2d   %b     %h %h", $time,clock,InstrReg,WriteData);
    clock = 1;
    #18 $finish;
end
endmodule
