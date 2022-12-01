// Módulo alu_mux 
module alu_mux(irsta_bus, ram_bus, alu_mux_sel, alu_in);
  // I/O declaration
  input [7:0] irsta_bus;     //Bus.
  input [7:0] ram_bus;       //Bus.
  input  alu_mux_sel;        //Selector del MUX.
  output reg [7:0] alu_in;   //Salida MUX.

  // Description
  always @(irsta_bus, ram_bus, alu_mux_sel)
  begin
    if(alu_mux_sel==1)       //Selector.
       alu_in = irsta_bus;  
    else  
       alu_in = ram_bus;               
  end 
endmodule