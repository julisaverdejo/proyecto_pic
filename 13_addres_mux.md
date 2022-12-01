## 13. Multiplexor selector de direcciones

- **Descripción:** Multiplexor selector de direcciones. Selecciona entre el [04_instruction_reg](04_instruction_reg.md) y el [14_fsr](14_fsr.md).

- Código
```verilog
module addr_mux(ir_bus, fsr_bus, addr_mux_sel, addr);}

	// I/O declaration
	input [4:0]  ir_bus;
	input [4:0]  fsr_bus;
	input  addr_mux_sel;
	output reg [4:0] addr;
	
	// Description
	assign addr = addr_mux_sel ? ir_bus : fsr_bus;  
	
endmodule
```

 - Testbench
```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_mux; 
	
	// Aux signals for testbench
	reg [4:0] mux_out;
	reg [4:0] in0, in1;
	reg sel;
	
	// Instantiation DUT (Device Under Test)
	addr_mux DUT (in0, in1, sel,mux_out);
	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	initial begin	
		in0 = 4'h01;
		in1 = 4'h02;
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