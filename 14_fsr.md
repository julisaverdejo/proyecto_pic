## 14. FSR (File Select Register)

- **Descripción:** File Select Register

- Código
```verilog
module fsr_reg(clk, rst, fsr_load, alu_bus, fsr_bus);

	// I/O declaration
	input clk;
	input rst;
	input fsr_load;
	input [7:0] alu_bus;
	output reg [4:0] fsr_bus;
	
	// Description
	always @(posedge clk) begin
	if(rst)
		fsr_bus <= 0;
	else if(fsr_load)
		fsr_bus <= alu_bus;  
	end

endmodule
```

 - Testbench
```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_w_reg; 
	
	// Aux signals for testbench  
	reg  clk;
	reg  rst;
	reg  en;
	reg  [7:0] din;
	reg  [7:0] dout;
	
	// Instantiation DUT (Device Under Test)
	fsr_reg DUT (clk, rst, en, din, dout);;	
	
	localparam period = 20;
	
	//  Reset sequence
	initial begin
		clk = 0; rst = 0; en = 0; din = 8'd1; #period;
		rst = 1; #period;
		rst = 0; #period;
	end	   
	
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
		
	initial begin	
		#(period*4);
		
		// Load 
		din = 8'd1;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 8'd2;
		#(period*2);
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 8'd4;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
	end
endmodule
```

- [x] Sintesis