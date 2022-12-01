
## 1. Divisor de frecuencia

- **Descripción:** Divisor de frecuencia basado en un contador con reset automático y un flip-flop a la salida con comparador y reset. La formula para calcular `div_val` es `div_val` = (t*f_fpga)/2 -1

- Código
```verilog
module clk_div(clk, rst, slow_clk);
	
	// I/O declaration
	input  clk;
	input  rst;
	output slow_clk; 
	
	// Descrition
	localparam div_val = 50000000-1;
	integer	   count_val = 0;
	reg temp_clk = 0;
	
	// Simple Counter with auto reset
	always @(posedge clk) begin
		if( ( count_val == div_val ) || rst)
			count_val <= 0;	
		else
			count_val <= count_val + 1;		
	end
	
	// Comparator with flip-flop logic
	always @(posedge clk) begin
		if (rst)
			temp_clk <= 0;
		else if (count_val == div_val)
			temp_clk <= ~temp_clk;
		else
			temp_clk <= temp_clk;	
	end	  
    
	assign slow_clk = temp_clk;
endmodule
```
 
 - Testbench
```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_clk_div; 		
	
	// Aux signals for testbench
	reg  clk;
	reg  rst;
	reg  slow_clk; 
	
	// Instantiation DUT (Device Under Test)
	clk_div DUT (clk, rst, slow_clk);	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	// Reset sequence
	initial begin
		clk = 0; rst = 0; #period;
		rst = 1; #period;
		rst = 0; #period;
	end	   
    
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
endmodule
```

- [x] Sintesis