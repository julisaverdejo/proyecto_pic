// Testbench para procesador
// Time Unit = 1ns, precision = 100ps = 1/10 ns.
`timescale 1ns/100ps
module tb_procesador ();
 // Aux signals for testbench.
 reg clk;
 reg rst;
 reg [7:0] ram_bus;
// reg [4:0] fsr_bus;
 reg [8:0] pruebapc_out;
  
 // Instantiation DUT (Device Under Test).
 procesador DUT (
   .clk(clk), 
   .rst(rst)
//   .pruebapc_out(pruebapc_out)
 );

 // Time semiperiod 
 localparam semiperiod = 25;
  
 task period;
  #semiperiod clk=~clk; #semiperiod clk=~clk;    
 endtask
  
 initial begin
    clk=1; rst=1; period;
    rst=0;        period;
                  period;
                  period;
   
    period;
    period;
    period;
    period;
 
    period;
    period;
    period;
    period;
    
    period;
    period;
    period;
    period;
  
    period;
    period;
    period; 
    period;
  
   
   //Desbloquear para CALL Y RETLW 
    period;
    period;
    period; 
    period;
   
   
   /*
   //Desbloquear para DECFSZ Y INCFSZ
    period;
    period;
    period;
    period; 
   
    period;
    period;
    period; 
    period;
   */
 end
 
 initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
 end  
endmodule
