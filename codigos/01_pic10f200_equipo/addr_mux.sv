// Módulo multiplexor. 
module addr_mux(ir_bus, fsr_bus, addr_mux_sel, addr);
  // I/O declaration
  input [4:0]  ir_bus;          //Bus 
  input [4:0]  fsr_bus;         //Bus 
  input  addr_mux_sel;          //Selector del MUX.
  output reg [4:0] addr;        //Salida MUX.

  // Description
  always @(ir_bus, fsr_bus, addr_mux_sel, addr)
  begin
    if(addr_mux_sel==1)            //Selector.
      addr = ir_bus;            
    else  
      addr = fsr_bus;              
  end 
endmodule