## 6. Multiplexor del ALU

- **Descripción:** Multiplexor del ALU

- Esquemático

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


```

- Simulación

- [x] Sintesis