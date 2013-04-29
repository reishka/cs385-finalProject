// shift_left_logical.v
// Michael P. Lang
// 17 April 2013
// michael@mplang.net
//
// 16-bit left logical barrel shifter.

module shift_left_logical(out, in, shift_amount); 
    input [15:0] in; 
    input [3:0] shift_amount;
    output [15:0] out; 
    wire [15:0] p, q, r;

    mux_32_to_16 mux1(p, in[15:0], {in[7:0],8'b0}, shift_amount[3]),
                 mux2(q, p, {p[11:0],4'b0}, shift_amount[2]),
                 mux3(r, q, {q[13:0],2'b0}, shift_amount[1]),
                 mux4(out, r, {r[14:0],1'b0}, shift_amount[0]);
endmodule
