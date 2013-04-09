// cpu.v
// Michael P. Lang
// 24 March 2013
// michael@mplang.net
// Main CPU module.

module CPU (clock, PC, IFID_InstrReg, IDEX_InstrReg, WriteData);
    input clock;
    output [15:0] WriteData, IFID_InstrReg, IDEX_InstrReg;
    output [15:0] PC;

    // IF
    wire [15:0] NextPC;
    reg [15:0] PC, IFID_InstrReg;
    reg [15:0] InstrMem[0:511];

    alu_16_bit fetch(NextPC, unused1, unused2, unused3, PC, 1, 3'b010);

    // Read hex data from text file into InstrMem
    initial
        $readmemh("input3a.hex", InstrMem);

    // ID
    reg [15:0] IDEX_InstrReg;
    wire [5:0] control;
    reg IDEX_RegDst, IDEX_ALUSrc, IDEX_RegWrite;
    reg [2:0] IDEX_ALUctl;
    wire [15:0] ReadData1, ReadData2, SignExtend, WriteData;
    reg [15:0] IDEX_ReadData1, IDEX_ReadData2, IDEX_SignExtend;
    reg [1:0] IDEX_rt, IDEX_rd;

    register_file_4_by_16 regFile(ReadData1, ReadData2, IFID_InstrReg[11:10], IFID_InstrReg[9:8], WriteReg, WriteData, IDEX_RegWrite, clock);
    main_control mainCtrl(IFID_InstrReg[15:12], control); 

    assign SignExtend = {{8{IFID_InstrReg[7]}},IFID_InstrReg[7:0]}; // sign extension

    // EXE
    wire [15:0] B, ALUout;
    wire [1:0] WriteReg;

    alu_16_bit ex(ALUout, unused4, unused5, unused6, IDEX_ReadData1, B, IDEX_ALUctl);
    mux_4_to_2 mux1(WriteReg, IDEX_rt, IDEX_rd, IDEX_RegDst);
    mux_32_to_16 mux2(B, IDEX_ReadData2, IDEX_SignExtend, IDEX_ALUSrc);

    assign WriteData = ALUout;

    initial PC = 0;

    always @(negedge clock) begin 
        // Stage 1 -- IF
        PC <= NextPC;
        IFID_InstrReg <= InstrMem[PC];
    
        // Stage 2 -- ID
        IDEX_InstrReg <= IFID_InstrReg;
        {IDEX_RegDst, IDEX_ALUSrc, IDEX_RegWrite, IDEX_ALUctl} <= control;
        IDEX_ReadData1 <= ReadData1;
        IDEX_ReadData2 <= ReadData2;
        IDEX_SignExtend <= SignExtend;
        IDEX_rt <= IFID_InstrReg[9:8];
        IDEX_rd <= IFID_InstrReg[7:6];

        // Stage 3 -- EX
        // do nothing.
    end
endmodule


// Test module

module test ();

reg clock;
wire [15:0] PC, IFID_InstrReg, IDEX_InstrReg, WriteData;

CPU test_cpu(clock, PC, IFID_InstrReg, IDEX_InstrReg, WriteData);

always #1 clock = ~clock;

initial begin
    $display ("time PC  IFID_IR  IDEX_IR  WD");
    $monitor ("%2d  %3d  %h     %h     %h", $time, PC, IFID_InstrReg, IDEX_InstrReg, WriteData);
    clock = 1;
    #29 $finish;
end
endmodule
