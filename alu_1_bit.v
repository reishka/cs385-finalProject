// alu_1_bit.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 1-bit ALU module for use as the least-significant
// 15 bits of the 16-bit ALU.

module alu_1_bit(result, c_out, a, b, less, c_in, op);
    input a, b;
    input less;
    input c_in;
    input [2:0] op;
    output result, c_out;
    wire m, n, p, q, r;

    not g1(m, b);
    mux_2_to_1  mux1(n, b, m, op[2]);
    and g2(p, a, n);
    or  g3(q, a, n);
    full_adder  fa(r, c_out, a, n, c_in);
    mux_4_to_1  mux2(result, p, q, r, less, op[1:0]);
endmodule
