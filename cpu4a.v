// cpu4a.v
// Michael P. Lang
// 4 April 2013
// michael@mplang.net
// Main CPU module.

module CPU (clock, PC, IFID_InstrReg, IDEX_InstrReg, EXMEM_InstrReg, MEMWB_InstrReg, WriteData);
    input clock;
    output [15:0] PC, WriteData, IFID_InstrReg, IDEX_InstrReg, EXMEM_InstrReg, MEMWB_InstrReg;

    // IF
    wire [15:0] NextPC, PCplus1;
    reg [15:0] PC, IFID_InstrReg;
    reg [15:0] InstrMem[0:511];

    alu_16_bit fetch(PCplus1, unused1, unused2, unused3, PC, 1, 3'b010);
    mux_32_to_16 mux1(NextPC, PCplus1, EXMEM_SignExtend, PCsrc);

    // Read hex data from text file into InstrMem
    initial begin
        $readmemh("input4.hex", InstrMem);

        DataMem[0] = 16'h5; // switch the cells and see how the simulation output changes
        DataMem[1] = 16'h7; // (beq is taken if [0]=16'h7; [1]=16'h5, not taken otherwise)
    end

    // ID
    reg [15:0] IDEX_InstrReg;
    wire [9:0] control;
    reg IDEX_RegDst, IDEX_BEQ, IDEX_BNE, IDEX_MemToReg, IDEX_MemWrite, IDEX_ALUsrc, IDEX_RegWrite;
    reg [2:0] IDEX_ALUctl;
    wire [15:0] ReadData1, ReadData2, SignExtend, WriteData;
    reg [15:0] IDEX_ReadData1, IDEX_ReadData2, IDEX_SignExtend;
    reg [1:0] IDEX_rt, IDEX_rd;

    register_file_4_by_16 regFile(ReadData1, ReadData2, IFID_InstrReg[11:10], IFID_InstrReg[9:8], MEMWB_WriteReg, WriteData, MEMWB_RegWrite, clock);
    main_control mainCtrl(IFID_InstrReg[15:12], control); 

    assign SignExtend = {{8{IFID_InstrReg[7]}},IFID_InstrReg[7:0]}; // sign extension

    // EX
    wire [15:0] B, ALUout;
    wire [1:0] WriteReg;
    wire Zero;
    reg EXMEM_RegWrite, EXMEM_MemToReg;
    reg EXMEM_MemWrite, EXMEM_BEQ, EXMEM_BNE;
    reg EXMEM_Zero;
    reg [15:0] EXMEM_SignExtend, EXMEM_ALUout, EXMEM_ReadData2;
    reg [15:0] EXMEM_InstrReg;
    reg [1:0] EXMEM_WriteReg;

    alu_16_bit ex(ALUout, unused4, Zero, unused5, IDEX_ReadData1, B, IDEX_ALUctl);
    mux_4_to_2 mux2(WriteReg, IDEX_rt, IDEX_rd, IDEX_RegDst);
    mux_32_to_16 mux3(B, IDEX_ReadData2, IDEX_SignExtend, IDEX_ALUsrc);

    // MEM
    wire [15:0] MemOut;
    wire NotZero, ne, eq, PCsrc;
    reg MEMWB_RegWrite, MEMWB_MemToReg;
    reg [15:0] DataMem[0:511];
    reg [15:0] MEMWB_MemOut, MEMWB_ALUout;
    reg [15:0] MEMWB_InstrReg;
    reg [1:0] MEMWB_WriteReg;

    not g1(NotZero, EXMEM_Zero);
    and g2(ne, EXMEM_BNE, NotZero),
        g3(eq, EXMEM_BEQ, EXMEM_Zero);
    or  g4(PCsrc, ne, eq);

    assign MemOut = DataMem[EXMEM_ALUout];

    always @(negedge clock) begin
        if(EXMEM_MemWrite)
            DataMem[EXMEM_ALUout] <= EXMEM_ReadData2;
    end

    // WB
    mux_32_to_16 mux4(WriteData, MEMWB_ALUout, MEMWB_MemOut, MEMWB_MemToReg);

    initial begin
        // Initialize registers
        PC = 0;

        IFID_InstrReg = 0;

        IDEX_InstrReg = 0;
        IDEX_RegDst = 0;
        IDEX_BEQ = 0;
        IDEX_BNE = 0;
        IDEX_MemToReg = 0;
        IDEX_MemWrite = 0;
        IDEX_ALUsrc = 0;
        IDEX_RegWrite = 0;
        IDEX_ALUctl = 3'b000;
        IDEX_ReadData1 = 0;
        IDEX_ReadData2 = 0;
        IDEX_SignExtend = 0;
        IDEX_rd = 0;
        IDEX_rt = 0;

        EXMEM_InstrReg = 0;
        EXMEM_BEQ = 0;
        EXMEM_BNE = 0;
        EXMEM_MemToReg = 0;
        EXMEM_MemWrite = 0;
        EXMEM_RegWrite = 0;
        EXMEM_ALUout = 0;
        EXMEM_ReadData2 = 0;
        EXMEM_SignExtend = 0;
        EXMEM_WriteReg = 0;
        EXMEM_Zero = 0;

        MEMWB_MemToReg = 0;
        MEMWB_RegWrite = 0;
        MEMWB_ALUout = 0;
        MEMWB_InstrReg = 0;
        MEMWB_MemOut = 0;
        MEMWB_WriteReg = 0;
    end

    always @(negedge clock) begin 
        // Stage 1 -- IF
        IFID_InstrReg <= InstrMem[PC];
        PC <= NextPC;
    
        // Stage 2 -- ID
        IDEX_InstrReg <= IFID_InstrReg;
        {IDEX_RegDst, IDEX_BEQ, IDEX_BNE, IDEX_MemToReg, IDEX_MemWrite, IDEX_ALUsrc, IDEX_RegWrite, IDEX_ALUctl} <= control;
        IDEX_ReadData1 <= ReadData1;
        IDEX_ReadData2 <= ReadData2;
        IDEX_SignExtend <= SignExtend;
        IDEX_rt <= IFID_InstrReg[9:8];
        IDEX_rd <= IFID_InstrReg[7:6];

        // Stage 3 -- EX
        EXMEM_InstrReg <= IDEX_InstrReg;
        EXMEM_RegWrite <= IDEX_RegWrite;
        EXMEM_MemToReg <= IDEX_MemToReg;
        EXMEM_BEQ <= IDEX_BEQ;
        EXMEM_BNE <= IDEX_BNE;
        EXMEM_MemWrite <= IDEX_MemWrite;
        EXMEM_Zero <= Zero;
        EXMEM_ALUout <= ALUout;
        EXMEM_ReadData2 <= IDEX_ReadData2;
        EXMEM_WriteReg <= WriteReg;
        EXMEM_SignExtend <= IDEX_SignExtend;

        // Stage 4 -- MEM
        MEMWB_InstrReg <= EXMEM_InstrReg;
        MEMWB_RegWrite <= EXMEM_RegWrite;
        MEMWB_MemToReg <= EXMEM_MemToReg;
        MEMWB_MemOut <= MemOut;
        MEMWB_ALUout <= EXMEM_ALUout;
        MEMWB_WriteReg <= EXMEM_WriteReg;
    end
endmodule
