## 4. Instruction Register (IR) 

* **Descripción:** Instruction register como un simple flip-flop D con habilitación basado en la documentación oficial de Xilinx.

- Esquemático

- Código
```verilog
module i_reg(clk, rst, en, din, dout);
	
	// I/O declaration
	input  clk;
	input  rst;
	input  en;
	input  [11:0] din;
	output [11:0] dout;
	
	// Descrition
	reg [11:0] d_reg;
	always @(posedge clk) begin
		if(rst)
			d_reg <= 0;
		else if (en)
			d_reg <= din;
	end
	
	assign dout = d_reg;
	
endmodule
```

 - Testbench
```verilog
`timescale 1 ns / 100 ps  
module tb_i_reg; 
	
	// Aux signals for testbench  
	reg  clk;
	reg  rst;
	reg  en;
	reg  [11:0] din;
	reg  [11:0] dout;
	
	// Instantiation DUT (Device Under Test)
	i_reg DUT (clk, rst, en, din, dout);;	
	
	localparam period = 20;
	
	//  Reset sequence
	initial begin
		clk = 0; rst = 0; en = 0; din = 12'd1; #period;
		rst = 1; #period;
		rst = 0; #period;
	end	   
	
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
		
	initial begin	
		#(period*4);
		
		// Load 
		din = 12'd1;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 12'd2;
		#(period*2);
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 12'd4;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
	end
endmodule
```

- Simulación