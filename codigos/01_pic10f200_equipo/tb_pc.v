/* Engineer: Jose David Rodiguez Muñoz
 * Date: 02/11/2022
 * Design Name:	tb_pc.v
 * Status: Complete
 * Description: program counter			 
*/
`timescale 1ns / 100ps
module tb_pc();
	reg  CLK_TB;
	reg  [7:0] IN_TB;
	reg  [1:0] CONTROL_TB;
	reg  [8:0] STACK_TB;
	wire [8:0] OUT_TB;
  
	pc DUT (.clk(CLK_TB), .pc_in(IN_TB), .pc_control(CONTROL_TB), .pc_stack(STACK_TB), .pc_out(OUT_TB));

	integer i;
	
initial
begin
	CLK_TB = 1;  
	IN_TB= 'h25;
	STACK_TB= 'hff;
   
	for (i=0; i <5; i=i+1) begin
		CONTROL_TB='b01;     
		#500 CLK_TB = ~CLK_TB; #500 CLK_TB = ~CLK_TB; 
	end
   
	CONTROL_TB='b11;  #500 CLK_TB = ~CLK_TB; #500 CLK_TB = ~CLK_TB;
	CONTROL_TB='b00;  #500 CLK_TB = ~CLK_TB; #500 CLK_TB = ~CLK_TB; 
	CONTROL_TB='b10;  #500 CLK_TB = ~CLK_TB; #500 CLK_TB = ~CLK_TB;
end
  
 initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
 end  
endmodule