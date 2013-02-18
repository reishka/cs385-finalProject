// decoder_2_to_4.v
// Michael P. Lang
// 18 February 2013
// michael@mplang.net
//
// 2-bit to 4-bit decoder.

module decoder_2_to_4(out, sel);

    input [1:0] sel;
    output [3:0] out;
    wire not_sel0, not_sel1;

    not n0(not_sel0, sel[0]),
        n1(not_sel1, sel[1]);
    and a0(out[0], not_sel0, not_sel1),
        a1(out[1], sel[0], not_sel1),
        a2(out[2], not_sel0, sel[1]),
        a3(out[3], sel[0], sel[1]);
endmodule
