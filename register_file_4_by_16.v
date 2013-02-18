// register_file_4_by_16.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 4-word by 16-bits-per-word register file.
// Register r0 is the constant 0.

module register_file_4_by_16(read_data1, read_data2, read_reg1, read_reg2, write_reg, write_data, reg_write, clk);

    input [1:0] read_reg1, read_reg2, write_reg;
    input [15:0] write_data;
    input reg_write, clk;
    output [15:0] read_data1, read_data2;
    wire [3:0] w, c;
    wire p;
    wire [15:0] q1, q2, q3;

    decoder_2_to_4 dec(w, write_reg);
    and g1(p, reg_write, clk),
        g2(c[1], p, w[1]),
        g3(c[2], p, w[2]),
        g4(c[3], p, w[3]);

    register_16_bit r1(q1, write_data, c[1]),
                    r2(q2, write_data, c[2]),
                    r3(q3, write_data, c[3]);

    mux_64_to_16 m1(read_data1, 0, q1, q2, q3, read_reg1),
                 m2(read_data2, 0, q1, q2, q3, read_reg2);

endmodule
