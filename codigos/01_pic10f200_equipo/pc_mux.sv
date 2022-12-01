// Módulo multiplexor para el pc. 
module pc_mux(stack_bus, alu_bus, pc_mux_sel, pc_mux_in);
  // I/O declaration
  input [8:0] stack_bus;        //Bus de la pila.
  input [7:0] alu_bus;          //Bus de la ALU.
  input  pc_mux_sel;            //Selector del MUX.
  output reg [8:0] pc_mux_in;   //Salida MUX.

  // Description
  always @(stack_bus, alu_bus, pc_mux_sel)
  begin
    if(pc_mux_sel==1)               //Selector.
       pc_mux_in = {'b0, alu_bus};  //ALU a la salida.
    else  
       pc_mux_in = stack_bus;       //Pila a la salida.               
  end 
endmodule