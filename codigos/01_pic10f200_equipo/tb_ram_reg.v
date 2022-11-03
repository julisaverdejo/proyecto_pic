/* Engineer: Julisa Verdejo Palacios
 * Date: 02/11/2022
 * Design Name:	tb_ram_reg.v
 * Status: Complete
 * Description: Testbech for ram_reg.v module
 * Run time: run 200 ns							 
*/

// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_ram_reg; 
	
	// Aux signals for testbench
	reg  clk;
	reg  rst;
	reg  we;
	reg  [4:0] addr;
	reg  [7:0] din;
	reg  [7:0] dout;	
	
	// Instantiation DUT (Device Under Test)
	ram_reg DUT (clk, rst, we, addr, din, dout);	
	
	//single_port_ram DUT (din, addr, we, clk, dout);	
	
	//rams_sp_wf DUT (clk, rst, we, addr, din, dout);
	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	// Initialitation and Reset sequence
	initial begin
		clk = 0;
		rst = 0;
		we = 0;
		addr = 5'd0;
		din  = 8'd1;
		#period;
		
		rst = 1;
		#period;
		
		rst = 0;
		#period;
	end	   
	
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
		
	initial begin	
		#(period*4);
		
		// Write test
		addr = 5'd0;
		din  = 8'd1;
		we = 1;
		#period;
		we = 0;
		#period;   
		
		addr = 5'd4;
		din  = 8'd2;
		we = 1;
		#period;
		we = 0;
		#period;
		
		// Read test
		addr = 5'd0;
		#(period*2); 
		
		addr = 5'd4;
		#(period*2); 
		

		addr = 5'd8;
		#(period*2); 
	end
endmodule