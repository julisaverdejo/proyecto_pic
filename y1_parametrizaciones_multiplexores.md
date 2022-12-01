# Parametrización de multiplexores

Al parametricar algunos de los códigos reutilizamos estructuras lo cual simplifica el diseño.

## ALU Mux
```verilog
// Code your design here
module alu_mux (ram_data_bus, sfr_data_bus, alu_mux_sel, alu_out);
  
  parameter bits = 8;                         // Parameterized value
  
  input [bits - 1 : 0] ram_data_bus, sfr_data_bus; // MUX inputs
  input alu_mux_sel;                               // Selector input
  
  output reg [bits - 1 : 0] alu_out;               // MUX output

  always @(*)					    // values assignment by cases
	 begin
       case (alu_mux_sel)
 			2'b0 : alu_out = sfr_data_bus;
 			2'b1 : alu_out = ram_data_bus;
            default : alu_out = 1'bx;
 	   endcase
 	 end 

endmodule
```

## PC Mux
```verilog
module PC_mux (stack_bus, alu_bus, ir_reg_bus, pc_mux_sel, pc_mux_bus);
  
  parameter bits = 9;                         // Parameterized value
  
  input [bits - 1 : 0] stack_bus, ir_reg_bus; // Mux inputs
  input [bits - 2 : 0] alu_bus;               // Mux input
  input [1:0] pc_mux_sel;                     // Selector input
  
  output reg [bits - 1 : 0] pc_mux_bus;       // Mux output

  always @( * )
	 begin
       case (pc_mux_sel)
 			2'b00 : pc_mux_bus = stack_bus;    // Sel value = 0
 			2'b01 : pc_mux_bus = alu_bus;      // Sel Value = 1
            2'b10 : pc_mux_bus = ir_reg_bus;   // Sel Value = 2
            default : pc_mux_bus = 2'bxx;
 	   endcase
 	 end 

endmodule
```

## Program Mux
```verilog
module alu_mux_2_to_1 (program_bus, nop_bus, program_mux_sel, program_mux_bus);
  
  parameter bits = 12;              // Parameterized value
  
  input [bits - 1 : 0] program_bus, nop_bus;     // MUX inputs
  input program_mux_sel;                         // Selector input
  
  output reg [bits - 1 : 0] program_mux_bus;     // MUX output

  always @( * )                     // values assignment by cases
	 begin
       case (program_mux_sel)
 			1'b0 : program_mux_bus = program_bus;
 			1'b1 : program_mux_bus = nop_bus;
            default : program_mux_bus = 1'bx;
 	   endcase
 	 end 

endmodule
```

## Register Address Mux
```verilog
module register_address_mux (ir_reg_bus, fsr_reg_bus, 											 reg_addr_mux_sel, reg_addr_bus);
  
  parameter bits = 5;                 // Parameterized value
  
  input [bits - 1 : 0] ir_reg_bus, fsr_reg_bus;  // MUX inputs
  input reg_addr_mux_sel;                        // Selector input
  
  output reg [bits - 1 : 0] reg_addr_bus;        // MUX output

  always @( * )                       // values assignment by cases
	 begin
       case (reg_addr_mux_sel)
 			1'b0 : reg_addr_bus = ir_reg_bus;
 			1'b1 : reg_addr_bus = fsr_reg_bus;
            default : reg_addr_bus = 1'bx;
 	   endcase
 	 end 

endmodule
```

## Register Address Mux
```verilog
module sfr_mux (indf_reg_bus, tmr0_reg_bus, pcl_reg_bus, 						   status_reg_bus, fsr_reg_bus, triport5_bus, 						   triport6_bus, triport7_bus, sfr_mux_sel, 						   sfr_mux_bus);
  
  parameter bits = 8;                // Parameterized value    
  
  input [bits - 1 : 0] indf_reg_bus, tmr0_reg_bus, pcl_reg_bus, 						   status_reg_bus, fsr_reg_bus, triport5_bus, 						   triport6_bus, triport7_bus;   // MUX inputs
  
  input [2:0] sfr_mux_sel;               // Selector input
  
  output reg [bits - 1 : 0] sfr_mux_bus;   // MUX output

  always @( * )                      // values assignment by cases
	 begin
       case (sfr_mux_sel)
 			3'b000 : sfr_mux_bus = indf_reg_bus;
 			3'b001 : sfr_mux_bus = tmr0_reg_bus;
            3'b010 : sfr_mux_bus = pcl_reg_bus;
            3'b011 : sfr_mux_bus = status_reg_bus;
            3'b100 : sfr_mux_bus = fsr_reg_bus;
            3'b101 : sfr_mux_bus = triport5_bus;
            3'b110 : sfr_mux_bus = triport6_bus;
            3'b111 : sfr_mux_bus = triport7_bus;
            default : sfr_mux_bus = 1'bx;
 	   endcase
 	 end 

endmodule
```