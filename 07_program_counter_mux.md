## 7. Multiplexor del program counter

- **Descripción:** Multiplexor del ALU, selecciona entre la salida del [ALU](09_alu.md) y la salida de la [Stack](10_stack.md).

- Código
```verilog
module pc_mux(stack_bus, alu_bus, pc_mux_sel, pc_mux_in);

	// I/O declaration
	input [8:0] stack_bus;
	input [7:0] alu_bus;      
	input pc_mux_sel;        
	output [8:0] pc_mux_in;

  // Description
  assign pc_mux_in = pc_mux_sel ? {'b0,alu_bus} : stack_bus;  
endmodule
```

 - Testbench
```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_mux; 
	
	// Aux signals for testbench
	reg [8:0] mux_out;
	reg [8:0] in0;
	reg [7:0] in1;
	reg sel;
	
	// Instantiation DUT (Device Under Test)
	pc_mux DUT (in0, in1, sel, mux_out);
	
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