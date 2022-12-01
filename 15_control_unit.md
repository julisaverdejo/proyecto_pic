## 15. Unidad de control

- **Descripción:** Unidad de control, maquina de estado que contrala todas las señales para generar el datapath necesario para el correcto funcionamiento.

- Código
```verilog
module controlador(clk,rst,ir_bus,fz,pc_mux_sel,pc_inc,pc_load,ir_load,stack_inc,stack_dec,stack_load,irsta_mux_sel,alu_mux_sel,w_load,s_load,addr_mux_sel,we,fsr_load);
	// I/O declaration
	input clk;
	input rst;
	input fz;
	input [11:0] ir_bus;
	output reg pc_mux_sel;
	output reg pc_inc;
	output reg pc_load;
	output reg ir_load;
	output reg stack_inc;
	output reg stack_dec;
	output reg stack_load;
	output reg irsta_mux_sel;
	output reg alu_mux_sel;
	output reg w_load;
	output reg s_load;
	output reg addr_mux_sel;
	output reg we;
	output reg fsr_load;
  
	reg [1:0] edosig; 
	reg [1:0] edoact; 
	reg m_load;
	reg bit_d;
	reg salto;
	reg cero;

	initial begin
		pc_mux_sel<=1;
		pc_inc<=0;
		pc_load<=0;
		ir_load<=0;
		stack_inc<=0;    
		stack_dec<=0;     
		stack_load<=0; 
		irsta_mux_sel<=1;
		alu_mux_sel<=1;
		w_load<=0;
		s_load<=1;
		addr_mux_sel<=1;
		we<=0;
		fsr_load<=0;
		edosig<=0;
		edoact<=0;
		m_load<=0;
		bit_d<=0;
		salto<=0;
		cero<=0;
	end 
 
 // Description
  always @(posedge clk) begin
    if(rst==1)    
       begin
       edoact<=0; edosig<=0; #1;     
       pc_mux_sel<=1;
       pc_inc<=1;
       pc_load<=0;
       ir_load<=1;
       alu_mux_sel<=1;
       s_load<=1;
       m_load<=0;
       salto<=0;
        cero<=0;
       end
    else
      begin
        case(edosig) 
          'b00: decodificar();  //Decodificar 
          'b01: ejecutar();     //Ejecutar        
          'b10: memorizar();    //Almacenar en Ram
          'b11: buscar();       //Nueva instruccion
          default: edosig<=0;
        endcase        
      end
  end

////////Estados procesador//////////
//////////////EDO 0/////////////////
  task decodificar();
    begin
       edoact<=0; edosig<=1; #1; 
       pc_inc<=0;
       pc_load<=0;
       ir_load<=0; 
       alu_mux_sel<=1;
       w_load<=0;
      
      casex(ir_bus) 
///////////////////////////////////////////////////////// 
        
       12'b0001_11xx_xxxx: byte_operations(); //ADDWF
       12'b0001_01xx_xxxx: byte_operations(); //ANDWF
       12'b0000_011x_xxxx: byte_operations(); //clrf
       12'b0000_0100_0000: byte_operations(); //clrw
       12'b0010_01xx_xxxx: byte_operations(); //comf
       12'b0000_11xx_xxxx: byte_operations(); //DECF
       12'b0010_11xx_xxxx: byte_opera_jump(); //DECFZ
       12'b0010_10xx_xxxx: byte_operations(); //INCF
       12'b0011_11xx_xxxx: byte_opera_jump(); //INCFZ
       12'b0000_001x_xxxx: byte_operations(); //MOVWF
       12'b0010_00xx_xxxx: byte_operations(); //MOVF
       12'b0010_0000_0000:             nop(); //NOP
       12'b0011_01xx_xxxx: byte_operations(); //RFL
       12'b0011_00xx_xxxx: byte_operations(); //RRF 
       12'b0001_10xx_xxxx: byte_operations(); //XORW
        
/////////////////////////////////////////////////////////
        
       12'b0100_xxxx_xxxx: bite_operations(); //BCF Bit clear f 
       12'b0101_xxxx_xxxx: bite_operations(); //BSF Bit set f
           
/////////////////////////////////////////////////////////
        
       12'b1110_xxxx_xxxx: lite_operations(); //ANDLW 
       12'b1001_xxxx_xxxx: call();            //CALL 
       12'b101x_xxxx_xxxx: goto();            //GOTO
       12'b1100_xxxx_xxxx: lite_operations(); //MOVLW k
       12'b1000_xxxx_xxxx: retlw();           //RETLW 
       12'b1101_xxxx_xxxx: lite_operations(); //XORLW
        
      endcase
    end
  endtask

///////////////////EDO 1///////////////////
  task ejecutar();
    begin
      edoact<=1; edosig<=2; #1;
  ///Sin memorizar///
      if(m_load==0) begin 
        w_load<=0; we<=0; pc_inc<=0;
        stack_inc<=0; stack_load<=0; stack_dec<=0;
        pc_mux_sel<=1; pc_load<=0;
      end
      
  ///Para memorizar///    
      else whered();
    end
  endtask

////////////////////EDO 2//////////////////
  task memorizar();
    begin
       edoact<=2; edosig<=3; #1; 
       w_load<=0;
       we<=0;
       pc_inc<=0;
       pc_load<=0;
       bit_d<=0;
      
      if(salto==1) begin if(fz==1) cero<=1; end  //Para salto decfsz
    end
  endtask  
  
/////////////////////EDO 3/////////////////  
  task buscar();
    begin
       edoact<=3; edosig<=0; #1;  
       pc_load<=0;
       pc_inc<=1;
       ir_load<=1;   
       m_load<=0;
       
 //Intruccion en caso de saltos.
      if(salto==1) begin pc_inc<=0; ir_load<=0; end
    
    end
  endtask
  
///////////////////////
//////Auxiliares///////
///////////////////////
 
  task whered();    //Guardar en w o en f.   
    begin
      if(bit_d==1) 
        begin
         we<=1; 
         w_load<=0;
        end
      else
        begin
         we<=0; 
         w_load<=1;
        end 
    end
  endtask
  
  task estadod();   //Encontar valor del bit d.
    begin
       bit_d<=0;  
       if(('b0000_0010_0000 & ir_bus)!=0) bit_d<=1;
    end
  endtask
  
/////////////////////////////
////Tipo de instrucciones////
/////////////////////////////
  
/////////////////////////////
//////Orientadas a byte//////
/////////////////////////////
 task byte_operations(); 
   begin 
   alu_mux_sel<=0; 
   m_load<=1;        //Variable para usar RAM
   estadod();
     
   end
 endtask  
  
 task nop(); 
   begin 
   alu_mux_sel<=0; 
   m_load<=0;
   end
 endtask  
  
 task byte_opera_jump(); 
   begin  
     if(salto==1) 
        begin 
          if(cero==1) pc_inc<=1; 
          salto<=0;
          cero<=0;
        end
    else 
      begin
      byte_operations();
       salto<=1;
      end
   end
 endtask    
  
/////////////////////////////
//////Orientadas a bite//////
/////////////////////////////  
 task bite_operations(); 
   begin 
     alu_mux_sel<=0; 
     we<=1; 
 
     w_load<=0;
   end
 endtask   

/////////////////////////////
//////Literal y control//////
/////////////////////////////
 task lite_operations(); 
   begin 
       w_load<=1;
   end
 endtask 
  
 task call(); 
   begin  
     if(salto==1) begin pc_load<=1; stack_inc<=1;salto<=0; end
    else 
      begin
      stack_load<=1;
      salto<=1;
      end
   end
 endtask  
  
 task retlw(); 
   begin  
      pc_mux_sel<=0;
     if(salto==1) begin pc_load<=1; salto<=0; end
    else 
      begin
      stack_dec<=1;
      salto<=1;
      w_load<=1;
      end
   end
 endtask  
  
 task goto(); 
   begin 
     if(salto==1) begin pc_load<=1; salto<=0; end
     else salto<=1; 
   end
 endtask 
  
endmodule
```

- [ ] Sintesis