/* Engineer: Julisa Verdejo Palacios
 * Date: 02/11/2022
 * Design Name:	ram_registers.v
 * Status: Complete
 * Description: Single port RAM, Intel based code					 
*/
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
	//assign dout = addr >= 5'd8 ? temp : 0;
	
endmodule 
