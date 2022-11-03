/* Engineer: Julisa Verdejo Palacios
 * Date: 02/11/2022
 * Design Name:	mux.v
 * Status: Complete
 * Description: Multiplexor 2 inputs, 1 output, 8 bits bus							 
*/
module mux(sel, in0, in1, mux_out);
	
	// I/O declaration
	input  sel;
	input  [7:0] in0, in1;			
	output [7:0] mux_out;	
	
	// Description							
	assign mux_out = sel ? in1 : in0;  
	
endmodule