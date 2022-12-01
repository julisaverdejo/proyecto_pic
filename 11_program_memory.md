## 11. Program Memory

- **Descripción:** Memoria del programa, contienen las instrucciones a ejecutar.

- Código
```verilog
module program_memory(pc_out, program_bus);   

	// I/O declaration
	input  [8:0]  pc_out; 
	output [12:0] program_bus; 

	reg [12:0] program_regs[512];
    
	// Description
	initial begin                          
		program_regs[0] <= 'b1100_0000_0111;  //Movlw 7
		program_regs[1] <= 'b1110_0000_1101;  //andlw w con 13
		program_regs[2] <= 'b1100_0000_0111;  //Movlw 3
		program_regs[20] <='b1100_1111_1111;  //Movlw 255
		program_regs[23] <='b1100_0000_0001;  //Movlw 1
	end
	
  assign program_bus = program_regs[pc_out];
  
endmodule
```

- [ ] Sintesis