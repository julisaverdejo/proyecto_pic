// Módulo registro de trabajo
module w_reg(clk, rst, w_load, alu_bus, w_out); 
	// I/O declaration
	input  clk;
	input  rst;
	input  w_load;
	input  [7:0] alu_bus;
    output [7:0] w_out;
    
	// Descrition
	reg [7:0] d_reg;
	always @(posedge clk) begin
		if(rst)
			d_reg <= 0;
		else if (w_load)
			d_reg <= alu_bus;
	end
	assign w_out = d_reg;
endmodule