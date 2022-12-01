## 12. Status Register

- **Descripción:** Status Register

- Esquemático

- Código
```verilog
module status_reg(clk, rst, s_load, fc, fdc, fz, status_bus); 

	// I/O declaration
	input  clk;
	input  rst;
	input  s_load;
	input  fc;
	input  fdc;
	input  fz;
	output [7:0] status_bus;
    
	// Descrition
    reg [7:0] ds_reg;
  
    initial begin
      ds_reg <= 0;
    end
  
	always @(posedge clk) begin
		if(rst) begin
			ds_reg <= 0;
		end else if (s_load) begin 
			ds_reg[0] <= fc;
			ds_reg[1] <= fdc;
			ds_reg[2] <= fz;
		end
	end
	
	assign status_bus = ds_reg;
	
endmodule
```

 - Testbench
```verilog

```

- Simulación

- [x] Sintesis