module test_alu_math; 
    // inputs 
    reg signed [15:0] a, b;
    reg [2:0] op;
    // outputs
    wire signed [15:0] result;
    wire overflow, zero, c_out;

    alu_16_bit my_alu(result, overflow, zero, c_out, a, b, op);

    initial 
        begin 
            a = 0; b = 0; op = 2;
            #10 a = 0; b = 0; op = 6;
            #10 a = 0; b = 0; op = 7;

            #10 a = 5; b = 5; op = 2;
            #10 a = 5; b = 5; op = 6;
            #10 a = 5; b = 5; op = 7;

            #10 a = 5; b = 2; op = 2;
            #10 a = 5; b = 2; op = 6;
            #10 a = 5; b = 2; op = 7;

            #10 a = -3; b = -1; op = 2;
            #10 a = -3; b = -1; op = 6;
            #10 a = -3; b = -1; op = 7;

            #10 a = 1; b = 7; op = 2;
            #10 a = 1; b = 7; op = 6;
            #10 a = 1; b = 7; op = 7;

            #10 a = -4; b = -7; op = 2;
            #10 a = -4; b = -7; op = 6;
            #10 a = -4; b = -7; op = 7;

            #10 a = -5; b = 6; op = 2;
            #10 a = -5; b = 6; op = 6;
            #10 a = -5; b = 6; op = 7;

            #10 a = 0; b = -8; op = 2;
            #10 a = 0; b = -8; op = 6;
            #10 a = 0; b = -8; op = 7;

            #10 a = 16383; b = 1; op = 2;
            #10 a = 16383; b = 1; op = 6;
            #10 a = 16383; b = 1; op = 7;

            #10 a = 32700; b = 32000; op = 2;
            #10 a = 32700; b = 32000; op = 6;
            #10 a = 32700; b = 32000; op = 7;
        end

    initial 
        $monitor("%d %d %d %b %d %b %b %b", $time, a, b, op, result, overflow, zero, c_out);

endmodule
