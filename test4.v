// Test module
module test ();
    reg clock;
    wire [15:0] PC, IFID_InstrReg, IDEX_InstrReg, EXMEM_InstrReg, MEMWB_InstrReg, WriteData;

    CPU test_cpu(clock, PC, IFID_InstrReg, IDEX_InstrReg, EXMEM_InstrReg, MEMWB_InstrReg, WriteData);

    always #1 clock = ~clock;

    initial begin
        $display ("time PC  IFID_IR  IDEX_IR  EXMEM_IR MEMWB_IR WD");
        $monitor ("%2d  %3d  %h %h %h %h %h", $time, PC, IFID_InstrReg, IDEX_InstrReg, EXMEM_InstrReg, MEMWB_InstrReg, WriteData);
        clock = 1;
        #163 $finish;
    end
endmodule
