// shift_right_logical.v
// Michael P. Lang
// 17 April 2013
// michael@mplang.net
//
// 16-bit right logical barrel shifter.

module shift_right_logical(out, in, shift_amount); 
    input [15:0] in; 
    input [3:0] shift_amount;
    output [15:0] out; 
    wire [15:0] p, q, r;

    mux_32_to_16 mux1(p, in[15:0], {8'b0,in[15:8]}, shift_amount[3]),
                 mux2(q, p, {4'b0,p[15:4]}, shift_amount[2]),
                 mux3(r, q, {2'b0,q[15:2]}, shift_amount[1]),
                 mux4(out, r, {1'b0,r[15:1]}, shift_amount[0]);
endmodule
