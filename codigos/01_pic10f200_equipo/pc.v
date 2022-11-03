/* Engineer: Jose David Rodiguez Muñoz
 * Date: 02/11/2022
 * Design Name:	pc.v
 * Status: Complete
 * Description: program counter			 
*/
module pc(clk, pc_in, pc_control, pc_stack, pc_out);
	// I/O declaration
	input clk,                  // Ciclo de instruccion 1 uS.
	input [7:0] pc_in,          // Datos provenientes de la ALU (saltos).
	input [1:0] pc_control,     // Señales de control para el PC.
    input [8:0] pc_stack,       // Datos provenientes de la STACK.
	output reg [8:0] pc_out = 0 // Valor de salida (memoria y stack). 

	// Description
	always @(posedge clk) 
	begin
	   case(pc_control)
		  'b00: pc_out = 0;           // Reset.
		  'b01: pc_out = pc_out + 1;  // PC + 1.
		  'b10: pc_out = pc_in;       // Cargar valor de ALU en PC.
		  'b11: pc_out = pc_stack;    // Cargar valor de STACK.
		  default: pc_out = 0;        // Default Reset.
	  endcase 
	end
endmodule
