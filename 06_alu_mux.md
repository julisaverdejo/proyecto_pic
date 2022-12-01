## 6. Multiplexor del ALU

- **Descripción:** Multiplexor del ALU, selecciona entre la salida del [multiplexor del IR](08_irsta_mux.md) y la salida de la [RAM](02_ram.md).

- Código
```verilog
module alu_mux(irsta_bus, ram_bus, alu_mux_sel, alu_in);

	// I/O declaration
	input [7:0] irsta_bus;
	input [7:0] ram_bus;      
	input alu_mux_sel;        
	output [7:0] alu_in;
	
	// Description
	assign alu_in = alu_mux_sel ? irsta_bus : ram_bus;  
endmodule
```

 - Testbench
```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_mux; 
	
	// Aux signals for testbench
	reg [7:0] mux_out;
	reg [7:0] in0, in1;
	reg sel;
	
	// Instantiation DUT (Device Under Test)
	alu_mux DUT (in0, in1, sel,mux_out);
	
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
```

- [x] Sintesis