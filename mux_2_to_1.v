// mux_2_to_1.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 2-to-1 multiplexer module.

module mux_2_to_1(x, a, b, sel); 
    input a, b, sel; 
    output x; 
    wire p, q, r; 

    not g1 (p, sel);
    and g2 (q, a, p), 
        g3 (r, b, sel);
    or  g4 (x, q, r); 
endmodule
