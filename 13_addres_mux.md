## 13. Multiplexor selector de direcciones

- **Descripción:** Multiplexor selector de direcciones

- Esquemático

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

```

- Simulación

- [x] Sintesis