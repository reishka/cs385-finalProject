// register_16_bit.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 16-bit register.

module register_16_bit(out, in, clk);
    input [15:0] in;
    input clk;
    output [15:0] out;

    d_flip_flop d0(in[0], clk, out[0]),
                d1(in[1], clk, out[1]),
                d2(in[2], clk, out[2]),
                d3(in[3], clk, out[3]),
                d4(in[4], clk, out[4]),
                d5(in[5], clk, out[5]),
                d6(in[6], clk, out[6]),
                d7(in[7], clk, out[7]),
                d8(in[8], clk, out[8]),
                d9(in[9], clk, out[9]),
                d10(in[10], clk, out[10]),
                d11(in[11], clk, out[11]),
                d12(in[12], clk, out[12]),
                d13(in[13], clk, out[13]),
                d14(in[14], clk, out[14]),
                d15(in[15], clk, out[15]);
endmodule
