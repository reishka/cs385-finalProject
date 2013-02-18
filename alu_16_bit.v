// alu_16_bit.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
// 16-bit ALU module.

module alu_16_bit(result, overflow, zero, c_out, a, b, op);
    input [15:0] a;
    input [15:0] b;
    input [2:0] op;
    output [15:0] result;
    output overflow, zero, c_out;
    wire p, q, r, s, t, u, v, w, x;
    wire less;

    alu_4_bit alu_0(result[3:0], s, p, a[3:0], b[3:0], less, op[2], op),
              alu_1(result[7:4], t, q, a[7:4], b[7:4], 0, p, op),
              alu_2(result[11:8], u, r, a[11:8], b[11:8], 0, q, op);
    alu_4_bit_last alu_3(result[15:12], overflow, less, v, c_out, a[15:12], b[15:12], r, op); 
    and  g1(w, s, t),
         g2(x, u, v),
         g3(zero, w, x);
endmodule
