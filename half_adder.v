// half_adder.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// Half-adder module.

module half_adder(sum, c_out, a, b); 
    input a, b; 
    output sum, c_out; 
    
    xor g1 (sum, a, b);
    and g2 (c_out, a, b);
endmodule
