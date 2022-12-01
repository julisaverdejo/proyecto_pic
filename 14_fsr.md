## 14. FSR (File Select Register)

- **Descripción:** File Select Register

- Esquemático

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

```

- Simulación

- [x] Sintesis