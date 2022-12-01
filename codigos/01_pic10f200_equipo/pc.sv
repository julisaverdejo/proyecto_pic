// Módulo contador de programa. 
module pc (clk, rst, pc_inc, pc_load, pc_mux_in, pc_out);
  // I/O declaration
  input clk;                 //Ciclo de instruccion.
  input rst;                 //Reset.
  input pc_inc;              //Incrementa el registro PC. 
  input pc_load;             //Carga el dato.
  input [8:0] pc_mux_in;     //Datos provenientes de la ALU o la pila.
  output reg [8:0] pc_out;   //Datos de salida para la memoria y la pila. 
  
  // Description
  always @(posedge clk) 
  begin
        if(rst==1)     pc_out <= 0;          //Señal de reset. 
   else if(pc_load==1) pc_out <= pc_mux_in;  //Señal para cargar datos.
   else if(pc_inc==1)  pc_out <= pc_out +1;  //Señal para incrementar +1 PC
    
  end
endmodule