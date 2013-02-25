// mux_32_to_16.v
// Michael P. Lang
// 22 February 2013
// michael@mplang.net
//
// 2x16-bit to 16-bit multiplexer.

module mux_32_to_16(x, a, b, sel); 
    input [15:0] a, b; 
    input sel;
    output [15:0] x; 

    mux_2_to_1 m0(x[0], a[0], b[0], sel),
               m1(x[1], a[1], b[1], sel),
               m2(x[2], a[2], b[2], sel),
               m3(x[3], a[3], b[3], sel),
               m4(x[4], a[4], b[4], sel),
               m5(x[5], a[5], b[5], sel),
               m6(x[6], a[6], b[6], sel),
               m7(x[7], a[7], b[7], sel),
               m8(x[8], a[8], b[8], sel),
               m9(x[9], a[9], b[9], sel),
               m10(x[10], a[10], b[10], sel),
               m11(x[11], a[11], b[11], sel),
               m12(x[12], a[12], b[12], sel),
               m13(x[13], a[13], b[13], sel),
               m14(x[14], a[14], b[14], sel),
               m15(x[15], a[15], b[15], sel);
endmodule
