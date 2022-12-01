// Módulo registro de fsr
module fsr_reg(clk, rst, fsr_load, alu_bus, fsr_bus);
  // I/O declaration
  input clk;                 //Ciclo de instruccion.
  input rst;                 //Reset.
  input fsr_load;            //Carga el dato.
  input [7:0] alu_bus;       //Datos provenientes ALU.
  output reg [4:0] fsr_bus;  //Datos de salida
  
 // Description
 always @(posedge clk) 
  begin
    if(rst==1)           fsr_bus <= 0;       //Señal de reset. 
    else if(fsr_load==1) fsr_bus <= alu_bus;  
  end
endmodule