// D_flip_flop.v
// Michael P. Lang
// 25 February 2013
// michael@mplang.net
//
// D-flip-flop module.

module d_flip_flop(D,CLK,Q);
   input D,CLK; 
   output Q; 
   wire CLK1, Y;
   not  not1 (CLK1,CLK);
   d_latch D1(D,CLK, Y),
           D2(Y,CLK1,Q);
endmodule 
