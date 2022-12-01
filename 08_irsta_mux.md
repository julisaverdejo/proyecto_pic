## 8. Multiplexor de registro IR

- **Descripción:** Multiplexor de registro IR, selecciona entre el [instruction_reg](04_instruction_reg.md) y el [status_reg](12_status_reg.md).

- Código
```verilog
module irsta_mux(ir_bus, status_bus, irsta_mux_sel, irsta_bus);

	// I/O declaration
	input [11:0] ir_bus;          
	input [7:0]  status_bus;      
	input  irsta_mux_sel;      
	output [7:0] irsta_bus;   

	// Description
	assign irsta_bus = irsta_mux_sel ? ir_bus : status_bus; 

endmodule
```

 - Testbench
```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_mux; 
	
	// Aux signals for testbench
	reg [7:0] mux_out;
	reg [11:0] in0;
	reg [7:0] in1;
	reg sel;
	
	// Instantiation DUT (Device Under Test)
	irsta_mux DUT (in0, in1, sel, mux_out);
	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	initial begin	
		in0 = 11'h01;
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