// mux_64_to_16.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 64-bit to 16-bit multiplexer.

module mux_64_to_16(x, a, b, c, d, sel); 
    input [15:0] a, b, c, d; 
    input [1:0] sel;
    output [15:0] x; 

    mux_4_to_1 m0(x[0], a[0], b[0], c[0], d[0], sel),
               m1(x[1], a[1], b[1], c[1], d[1], sel),
               m2(x[2], a[2], b[2], c[2], d[2], sel),
               m3(x[3], a[3], b[3], c[3], d[3], sel),
               m4(x[4], a[4], b[4], c[4], d[4], sel),
               m5(x[5], a[5], b[5], c[5], d[5], sel),
               m6(x[6], a[6], b[6], c[6], d[6], sel),
               m7(x[7], a[7], b[7], c[7], d[7], sel),
               m8(x[8], a[8], b[8], c[8], d[8], sel),
               m9(x[9], a[9], b[9], c[9], d[9], sel),
               m10(x[10], a[10], b[10], c[10], d[10], sel),
               m11(x[11], a[11], b[11], c[11], d[11], sel),
               m12(x[12], a[12], b[12], c[12], d[12], sel),
               m13(x[13], a[13], b[13], c[13], d[13], sel),
               m14(x[14], a[14], b[14], c[14], d[14], sel),
               m15(x[15], a[15], b[15], c[15], d[15], sel);
endmodule
