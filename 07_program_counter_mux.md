## 7. Multiplexor del program counter

- **Descripción:** Multiplexor del program counter

- Esquemático

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

```

- Simulación

- [x] Sintesis