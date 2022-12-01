// Módulo registro status
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
		if(rst)
		ds_reg <= 0;
      else if (s_load)
        ds_reg[0] <= fc;
        ds_reg[1] <= fdc;
        ds_reg[2] <= fz;
	end
	assign status_bus = ds_reg;
endmodule
