// Módulo multiplexor ir y status. 
module irsta_mux(ir_bus, status_bus, irsta_mux_sel, irsta_bus);
  // I/O declaration
  input [11:0] ir_bus;          //Bus.
  input [7:0]  status_bus;      //Bus.
  input  irsta_mux_sel;         //Selector del MUX.
  output reg [7:0] irsta_bus;   //Salida MUX.

  // Description
  always @(ir_bus, status_bus, irsta_mux_sel, irsta_bus)
  begin
    if(irsta_mux_sel==1)            //Selector.
      irsta_bus = ir_bus;            
    else  
      irsta_bus = status_bus;              
  end 
endmodule