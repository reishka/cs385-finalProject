module test_alu_logic; 
    // inputs 
    reg [15:0] a, b;
    reg [2:0] op;
    // outputs
    wire [15:0] result;
    wire overflow, zero, c_out;

    alu_16_bit my_alu(result, overflow, zero, c_out, a, b, op);

    initial 
        begin 
            a = 0; b = 0; op = 0;
            #10 a = 0; b = 0; op = 1;

            #10 a = 5; b = 5; op = 0;
            #10 a = 5; b = 5; op = 1;

            #10 a = 5; b = 2; op = 0;
            #10 a = 5; b = 2; op = 1;

            #10 a = -3; b = -1; op = 0;
            #10 a = -3; b = -1; op = 1;

            #10 a = 1; b = 7; op = 0;
            #10 a = 1; b = 7; op = 1;

            #10 a = -4; b = -7; op = 0;
            #10 a = -4; b = -7; op = 1;

            #10 a = -5; b = 6; op = 0;
            #10 a = -5; b = 6; op = 1;

            #10 a = 0; b = -8; op = 0;
            #10 a = 0; b = -8; op = 1;
        end

    initial 
        $monitor("%d %b %b %b %b %b %b %b", $time, a, b, op, result, overflow, zero, c_out);

endmodule
