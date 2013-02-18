module test_reg_file;

 reg [1:0] rr1,rr2,wr;
 reg [15:0] wd;
 reg regwrite, clock;
 wire [15:0] rd1,rd2;

 register_file_4_by_16 regs(rd1,rd2,rr1,rr2,wr,wd,regwrite,clock);

 initial 
   begin  

     #10 regwrite=1; //enable writing

     #10 wd='b1100101000110101;       // set write data

     #10      rr1=0;rr2=0;clock=0;  //30
     #10 wr=1;rr1=1;rr2=1;clock=1;  //40
     #10                  clock=0;  //50
     #10 wr='b10;rr1='b10;rr2='b10;clock=1; //60
     #10                  clock=0;  //70
     #10 wr='b11;rr1='b11;rr2='b11;clock=1; //80
     #10                  clock=0;  //90

     #10 regwrite=0; //disable writing  //100

     #10 wd='b0010110111110000;       // set write data  //110

     #10 wr=1;rr1=1;rr2=1;clock=1;  //120
     #10                  clock=0;  //130
     #10 wr=2;rr1=2;rr2=2;clock=1;  //140
     #10                  clock=0;  //150
     #10 wr=3;rr1=3;rr2=3;clock=1;  //160
     #10                  clock=0;  //170

     #10 regwrite=1; //enable writing

     #10 wd=1;       // set write data

     #10 wr=1;rr1=1;rr2=1;clock=1;
     #10                  clock=0;
     #10 wr=2;rr1=2;rr2=2;clock=1;
     #10                  clock=0;
     #10 wr=3;rr1=3;rr2=3;clock=1;
     #10                  clock=0;

   end 

 initial
   $monitor ("%d regwrite=%b clock=%b rr1=%b rr2=%b wr=%b wd=%b rd1=%b rd2=%b",$time,regwrite,clock,rr1,rr2,wr,wd,rd1,rd2);
 
endmodule 
