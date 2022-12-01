// Módulo de la stack. LIFO
module stack (clk, rst, stack_inc, stack_dec, stack_load, pc_out, stack_bus, spointer);
  // I/O declaration
  input clk;                 //Ciclo de instruccion.
  input rst;                 //Reset.
  input stack_inc;           //Incrementa celda.
  input stack_dec;           //Decrementa celda.
  input stack_load;          //Graba datos provenientes del pc.
  input  [8:0] pc_out;       //Datos provenientes del pc.
  output [8:0] stack_bus;    //Datos de salida para el pc. 
  
  output reg spointer;       //Apuntador de la celda. 
  reg [8:0] stack_regs[2];   //Celdas de almacenamiento.
  
  // Description
  always @(posedge clk) 
  begin
         if(rst==1)        spointer <= 0;                //Señal de reset. 
    else if(stack_load==1) stack_regs[spointer]<=pc_out; //Memorizar dato en una celda.
    else if(stack_inc==1)  spointer <= spointer +1;      //Siguiente celda.
    else if(stack_dec==1)  spointer <= spointer -1;      //Celda anterior. 
   
  end
  
  assign stack_bus = stack_regs[spointer];
endmodule