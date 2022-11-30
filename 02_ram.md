## 2. RAM

- **Descripción:** Módulo RAM de un solo puerto con reset síncrono e inicialización a ceros con prioridad de escritura.

- Esquemático

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
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_ram_reg; 
    
	// Aux signals for testbench
	reg  clk;
	reg  rst;
	reg  we;
	reg  [4:0] addr;
	reg  [7:0] din;
	reg  [7:0] dout;	
	
	// Instantiation DUT (Device Under Test)
	ram_reg DUT (clk, rst, we, addr, din, dout);	
	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	// Initialitation and Reset sequence
	initial begin
		clk = 0; rst = 0; we = 0; addr = 5'd0; din  = 8'd1; #period;
		rst = 1; #period;
		rst = 0; #period;
	end
    
    // 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period 
	always #10 clk = ~clk; 
		
	initial begin	
		#(period*4);
		
		// Write test
		addr = 5'd0; din  = 8'd1; we = 1; #period;
		we = 0; #period;   
		
		addr = 5'd4; din  = 8'd2; we = 1; #period;
		we = 0; #period;
		
		// Read test
		addr = 5'd0; #(period*2); 
		addr = 5'd4; #(period*2); 
		addr = 5'd8; #(period*2); 
	end
endmodule
```

- Simulación

- [x] Sintesis