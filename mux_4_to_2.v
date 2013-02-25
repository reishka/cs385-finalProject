// mux_4_to_2.v
// Michael P. Lang
// 22 February 2013
// michael@mplang.net
//
// 2x2-bit to 2-bit multiplexer module.

module mux_4_to_2(x, a, b, sel); 
    input [1:0] a, b;
    input sel; 
    output [1:0] x; 

    mux_2_to_1 mux1(x[0], a[0], b[0], sel),
               mux2(x[1], a[1], b[1], sel); 
endmodule
