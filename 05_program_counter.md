## 5. Program counter

- **Descripción:** Contador de programa el cual incrementa el valor del registro en 1, reinicia o carga un valor dado dependiendo de sus entradas.

- Código
```verilog
module pc (clk, rst, pc_inc, pc_load, pc_mux_in, pc_out);

	// I/O declaration
	input clk;             
	input rst;                 
	input pc_inc;              
	input pc_load;            
	input [8:0] pc_mux_in;     
	output reg [8:0] pc_out;  
  
	// Description
	always @(posedge clk) begin
		if(rst)
			pc_out <= 0;          
		else if(pc_load)
			pc_out <= pc_mux_in; 
		else if(pc_inc)
			pc_out <= pc_out + 1; 
		end
endmodule 
```

- [x] Sintesis