## 10. Módulo Stack

- **Descripción:**  Módulo stack estructura LIFO

- Esquemático

- Código
```verilog
module stack (clk, rst, stack_inc, stack_dec, stack_load, pc_out, stack_bus);

	// I/O declaration
	input clk;                 
	input rst;                 
	input stack_inc;          
	input stack_dec;           
	input stack_load;         
	input  [8:0] pc_out;      
	output [8:0] stack_bus;   

	reg spointer;              
	reg [8:0] stack_regs[2];   
  
	// Description
	always @(posedge clk) begin
		if(rst)
			spointer <= 0;                
		else if(stack_load)
			stack_regs[spointer] <= pc_out; 
		else if(stack_inc)
			spointer <= spointer + 1;     
		else if(stack_dec) 
			spointer <= spointer - 1;      
	end
	
	assign stack_bus = stack_regs[spointer];
	
endmodule
```

 - Testbench
```verilog

```

- Simulación

- [x] Sintesis