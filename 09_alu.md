## 9. ALU

- **Descripción:** Módulo ALU

- Esquemático

- Código
```verilog
module alu(w_out,alu_in,ir_bus,alu_bus,fz,fc,fdc);

	// I/O declaration 
	input [7:0] w_out;        
	input [7:0] alu_in;       
	input [11:0] ir_bus;      
	output reg [7:0] alu_bus; 
	output reg fz;   
	output reg fc;   
	output reg fdc;
  
	initial begin
	fz = 0;
	fc = 0;
	fdc = 0;
	end 
  
	always @(w_out, alu_in, ir_bus) begin 
		casex(ir_bus)  
		/*------------------------------*/
		/*Byte-oriented file register op*/
		//ADDWF
		12'b0001_11xx_xxxx:addwf();
		//ANDWF
		12'b0001_01xx_xxxx:andwf();  
		//INCF
		12'b0010_10xx_xxxx:incf(); 
		//XORWF  
		12'b0001_10xx_xxxx:xorwf(); 
		
		/*-----------------------------*/
		/*Bit-oriented file register op*/
		//BCF Bit clear f
		12'b0100_xxxx_xxxx:bcf(); 
		//BSF Bit set f 
		12'b0101_xxxx_xxxx:bsf();

		/*-----------------------------*/
		/*Literan and control operaions*/
		//ANDLW
		12'b1110_xxxx_xxxx: andlw(); 
		// MOVLW
		12'b1100_xxxx_xxxx: movlw();
		//XORLW
		12'b1101_xxxx_xxxx: xorlw(); 
		endcase  
	end
 
	/*--------------------*/
	/* Flags descriptions */ 
	task flagZ();
		begin  
			if(alu_bus==0)
				fz = 1;
			else
				fz = 0;
		end
	endtask
 
	task flagC();
		begin  
			if (alu_bus < w_out) 
				fc = 1;
			else
				fc = 0; 
		end
	endtask 
  

	/*--------------------*/
	/* Tasks descriptions */
	task addwf();
		begin
			alu_bus= w_out + (alu_in & 'b0001_1111);  
			flagZ();
			flagC();
		end
	endtask 
  
	task andwf();
		begin
			alu_bus= w_out & alu_in;  
			flagZ();
		end
	endtask 
  
	task incf();
		begin
			alu_bus= alu_in +1;  
			flagZ();
		end
	endtask 
  
	task xorwf();
		begin
			alu_bus= w_out ^ alu_in;  
			flagZ();
		end
	endtask  
  
	task bcf();
		reg [2:0] b;
		reg [7:0] mask;
		begin
			b = ir_bus[7:5];
			mask = ~(1<<b);
			alu_bus = alu_in & mask;
		end
	endtask
  
	task bsf();
		reg [2:0] b;
		reg [7:0] mask;
		begin
			b = ir_bus[7:5];
			mask = (1<<b);
			alu_bus = alu_bus | mask;
		end
	endtask
  
	task andlw();
		begin
			alu_bus= w_out & alu_in;  
			flagZ();
		end
	endtask 
  
	task movlw();
		begin
			alu_bus = alu_in;
		end
	endtask
  
	task xorlw();
		begin
			alu_bus= w_out ^ alu_in;  
			flagZ();
		end
	endtask 

endmodule
```

 - Testbench
```verilog

```

- Simulación

- [ ] Sintesis