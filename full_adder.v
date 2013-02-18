// full_adder.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// Full-adder module.

module full_adder(sum, c_out, a, b, c_in);
    input a, b, c_in;
    output sum, c_out;
    wire p, q, r;
    
    half_adder ha1(p, q, a, b),
               ha2(sum, r, p, c_in);
    or g1(c_out, r, q);
endmodule
