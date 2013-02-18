// alu_4_bit.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 4-bit ALU module for use as the least-significant
// 12 bits of the 16-bit ALU.

module alu_4_bit(result, zero, c_out, a, b, less, c_in, op);
    input [3:0] a;
    input [3:0] b;
    input less;
    input c_in;
    input [2:0] op;
    output [3:0] result;
    output zero, c_out;
    wire p, q, r, s, t;

    alu_1_bit alu_0(result[0], p, a[0], b[0], less, c_in, op),
              alu_1(result[1], q, a[1], b[1], 0, p, op),
              alu_2(result[2], r, a[2], b[2], 0, q, op),
              alu_3(result[3], c_out, a[3], b[3], 0, r, op); 
    or  g1(s, result[0], result[1]),
        g2(t, result[2], result[3]);
    nor g3(zero, s, t);
endmodule
