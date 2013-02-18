// mux_4_to_1.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 4-to-1 multiplexer module

module mux_4_to_1(x, a, b, c, d, sel); 
    input a, b, c, d; 
    input [1:0] sel;
    output x; 
    wire p, q; 

    mux_2_to_1 mux1(p, a, b, sel[0]),
               mux2(q, c, d, sel[0]),
               mux3(x, p, q, sel[1]);
endmodule
