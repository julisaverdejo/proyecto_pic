// Módulo registro de instrucción. 
module ir_reg(clk, rst, ir_load, program_bus, ir_bus);
  // I/O declaration
  input clk;                 //Ciclo de instruccion.
  input rst;                 //Reset.
  input ir_load;             //Carga el dato.
  input [11:0] program_bus;  //Datos provenientes de memoria de programa.
  output reg [11:0] ir_bus;  //Datos de salida para la unidad de control. 
  
 // Description
 always @(posedge clk) 
  begin
         if(rst==1)     ir_bus <= 0;            //Señal de reset. 
    else if(ir_load==1) ir_bus <= program_bus;  //Señal para cargar datos.
    
  end
endmodule