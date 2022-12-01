## 16. Complete design

- **Descripción:** Diseño completo del PIC10F200, instanciación de todos los códigos.

- Código
```verilog
module ram_reg(clk, rst, we, addr, din, dout);
    
	// I/O declaration
	input  clk;
	input  rst;
	input  we;
	input  [4:0] addr;
	input  [7:0] din;
	output [7:0] dout;		
				
	// Description
	reg [7:0] ram[23:0];
	reg [4:0] addr_reg;
	integer i;
	
	always @ (posedge clk) begin
		if (rst) begin
			for(i=0; i<24; i=i+1)
				ram[i] <= 0;
		end
		if (we) begin
			ram[addr] <= din;
		end
		addr_reg <= addr;
	end
	
	assign dout = ram[addr_reg];
endmodule 
```

 - Testbench
```verilog
// Testbench para procesador
// Time Unit = 1ns, precision = 100ps = 1/10 ns.
`timescale 1ns/100ps
module tb_procesador ();
 // Aux signals for testbench.
 reg clk;
 reg rst;
 reg [7:0] ram_bus;
// reg [4:0] fsr_bus;
 reg [8:0] pruebapc_out;
  
 // Instantiation DUT (Device Under Test).
 procesador DUT (
   .clk(clk), 
   .rst(rst)
//   .pruebapc_out(pruebapc_out)
 );

 // Time semiperiod 
 localparam semiperiod = 25;
  
 task period;
  #semiperiod clk=~clk; #semiperiod clk=~clk;    
 endtask
  
 initial begin
    clk=1; rst=1; period;
    rst=0;        period;
                  period;
                  period;
   
    period;
    period;
    period;
    period;
   
    period;
    period;
    period;
    period;
   
    period;
    period;
    period;
    period;
   
    period;
    period;
    period; 
    period;

 end
 
 initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
 end  
endmodule

```

- [ ] Sintesis