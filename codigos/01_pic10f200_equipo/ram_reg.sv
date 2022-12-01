module ram_reg(clk, rst, we, addr, alu_bus, ram_bus);
	// I/O declaration
	input  clk;
	input  rst;
	input  we;
	input  [4:0] addr;
    input  [7:0] alu_bus;
    output [7:0] ram_bus;		
				
	// Description
    reg [7:0] ram[31:0];
	reg [4:0] addr_reg;
	integer i;
	
  initial begin
    ram[8]<='d15;
   end 
  
   always @ (posedge clk) begin
		if (rst) begin
          for(i=0; i<32; i=i+1)
				ram[i] <= 0;
		end
		if (we) begin
			ram[addr] <= alu_bus;
		end
		addr_reg <= addr;
	end
	
	assign ram_bus = ram[addr_reg];
endmodule