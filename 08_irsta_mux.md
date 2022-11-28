## 6. Multiplexor de registro IR

- **Descripción:** Multiplexor de registro IR

- Esquemático

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


```

- Simulación

- [x] Sintesis