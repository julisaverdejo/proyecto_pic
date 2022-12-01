// Procesador
//Dar de alta los otros archivos
`include "pc.sv"
`include "pc_mux.sv"
`include "program_memory.sv"
`include "ir_reg.sv"
`include "controlador.sv"
`include "stack.sv"
`include "irsta_mux.sv"
`include "alu_mux.sv"
`include "alu.sv"
`include "w_reg.sv"
`include "status_reg.sv"
`include "addr_mux.sv"
`include "ram_reg.sv"
`include "fsr_reg.sv"

module procesador(
  clk,
  rst
);
 
input clk;                   
input rst;       

//Wires de conexiones.  
wire [8:0] pc_mux_in;        
wire [8:0] pc_out;           
wire [12:0] program_bus;     
 
wire pc_mux_sel;
wire pc_inc;  
wire pc_load;   
wire ir_load;  
wire [11:0] ir_bus;  
  
wire stack_inc;               //Incrementa celda.
wire stack_dec;               //Decrementa celda.
wire stack_load;              //Graba datos provenientes del pc.  
wire [8:0] stack_bus;         //Datos de salida para el pc.  
 
wire irsta_mux_sel;
wire [7:0] irsta_bus;

wire alu_mux_sel;
wire [7:0] alu_in;
  
wire [7:0] w_out;
wire [7:0] alu_bus; 
wire w_load;
  
wire [7:0] status_bus; 
wire fc;
wire fdc;
wire fz;
  
wire addr_mux_sel;
wire [4:0] addr;
  
wire we;
wire [7:0] ram_bus;
  
wire fsr_load;
wire [4:0] fsr_bus;
  
pc module_pc(.clk(clk), .rst(rst), .pc_inc(pc_inc), .pc_load(pc_load), .pc_mux_in(pc_mux_in), .pc_out(pc_out));

pc_mux module_pc_mux(.stack_bus(stack_bus), .alu_bus(alu_bus), .pc_mux_sel(pc_mux_sel), .pc_mux_in(pc_mux_in));
  
program_memory module_program_memory(.pc_out(pc_out), .program_bus(program_bus));
  
ir_reg module_ir_reg(.clk(clk), .rst(rst), .ir_load(ir_load), .program_bus(program_bus), .ir_bus(ir_bus));
 
 controlador module_controlador(.clk(clk), .rst(rst), .ir_bus(ir_bus), .fz(fz), .pc_mux_sel(pc_mux_sel), .pc_inc(pc_inc), .pc_load(pc_load), .ir_load(ir_load), .stack_inc(stack_inc), .stack_dec(stack_dec), .stack_load(stack_load), .irsta_mux_sel(irsta_mux_sel), .alu_mux_sel(alu_mux_sel), .w_load(w_load), .s_load(s_load), .addr_mux_sel(addr_mux_sel), .we(we), .fsr_load(fsr_load));
  
stack module_stack(.clk(clk), .rst(rst), .stack_inc(stack_inc), .stack_dec(stack_dec), .stack_load(stack_load), .pc_out(pc_out), .stack_bus(stack_bus));  

irsta_mux module_irsta_mux(.ir_bus(ir_bus), .status_bus(status_bus), .irsta_mux_sel(irsta_mux_sel), .irsta_bus(irsta_bus));   
  
alu_mux module_alu_mux(.irsta_bus(irsta_bus), .ram_bus(ram_bus), .alu_mux_sel(alu_mux_sel), .alu_in(alu_in));  
  
alu module_alu(.w_out(w_out), .alu_in(alu_in), .ir_bus(ir_bus), .alu_bus(alu_bus), .fz(fz), .fc(fc), .fdc(fdc));  
  
w_reg module_w_reg(.clk(clk), .rst(rst), .w_load(w_load), .alu_bus(alu_bus), .w_out(w_out));  
  
status_reg module_status_reg(.clk(clk), .rst(rst), .s_load(s_load), .fc(fc), .fdc(fdc), .fz(fz), .status_bus(status_bus));

addr_mux module_addr_mux(.ir_bus(ir_bus), .fsr_bus(fsr_bus), .addr_mux_sel(addr_mux_sel), .addr(addr));
   
ram_reg module_ram_reg(.clk(clk), .rst(rst), .we(we), .addr(addr), .alu_bus(alu_bus), .ram_bus(ram_bus)); 
  
fsr_reg module_fsr_reg(.clk(clk), .rst(rst), .fsr_load(fsr_load), .alu_bus(alu_bus), .fsr_bus(fsr_bus));   
  
endmodule