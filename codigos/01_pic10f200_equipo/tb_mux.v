/* Engineer: Julisa Verdejo Palacios
 * Date: 02/11/2022
 * Design Name:	tb_mux.v
 * Status: Complete
 * Description: Testbech for mux.v module
 * Run time: run 200 ns							 
*/

// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_mux; 
	
	// Aux signals for testbench
	reg [7:0] mux_out;
	reg [7:0] in0, in1;
	reg sel;
	
	// Instantiation DUT (Device Under Test)
	mux DUT (sel, in0, in1, mux_out);
	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	initial begin	
		in0 = 8'h01;
		in1 = 8'h02;
		sel = 0;
		#period;
		
		sel = 1;
		#period; 
		
		sel = 0;
		#period;
	end
endmodule