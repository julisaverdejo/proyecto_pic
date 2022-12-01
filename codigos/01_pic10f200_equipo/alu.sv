// Módulo alu. 
module alu(w_out,alu_in,ir_bus,alu_bus,fz,fc,fdc);
 // I/O declaration 
 input [7:0] w_out;        //Entrada de W
 input [7:0] alu_in;       //Entrada del MUX
 input [11:0] ir_bus;      //Selector de operación
 output reg [7:0] alu_bus; //Salida ALU
 output reg fz;   
 output reg fc;   
 output reg fdc;
  
 initial begin
  fz = 0;
  fc = 0;
  fdc = 0;
 end 
  
 always @(w_out, alu_in, ir_bus)  
 begin 
   #1;
  casex(ir_bus)   
  //////////////////////////////////
  //BITE ORIENTED FILE REGISTER OP./
  //////////////////////////////////
   
    12'b0001_11xx_xxxx:addwf();  //ADDWF
    12'b0001_01xx_xxxx:andwf();  //ANDWF
    12'b0000_011x_xxxx: clrf();  //CLRF
    12'b0000_0100_0000: clrw();  //CLRW 
    12'b0010_01xx_xxxx: comf();  //COMF 
    12'b0000_11xx_xxxx: decf();  //DECF
    12'b0010_11xx_xxxx:decfz();  //DECFZ 
    12'b0010_10xx_xxxx: incf();  //INCF
    12'b0011_11xx_xxxx:incfz();  //INCFZ
    12'b0010_00xx_xxxx: movf();  //MOVF
    12'b0000_001x_xxxx:movwf();  //MOVWF
    12'b0000_0000_0000:  nop();  //NOP
    12'b0011_01xx_xxxx:  rfl();  //RFL
    12'b0011_00xx_xxxx:  rff();  //RFF
    12'b0001_10xx_xxxx:xorwf();  //XORWF
    
  //////////////////////////////////
  //BIT ORIENTED FILE REGISTER OP.//
  //////////////////////////////////
     
   12'b0100_xxxx_xxxx: bcf();    //BCF Bit clear f
   12'b0101_xxxx_xxxx: bsf();    //BSF Bit set f
    
  //////////////////////////////////
  //Literal and control operations//
  //////////////////////////////////
    
   12'b1110_xxxx_xxxx: andlw(); //ANDLW 
   12'b1001_xxxx_xxxx: call();  //CALL
   12'b1100_xxxx_xxxx: movlw(); //MOVLW
   12'b101x_xxxx_xxxx:  goto(); //GOTO
   12'b1000_xxxx_xxxx: retlw(); //RETLW
   12'b1101_xxxx_xxxx: xorlw(); //XORLW
    
  endcase  
 end
  
/////////////////////////////////////////
/////////////////Flags///////////////////
/////////////////////////////////////////
  
 task flagZ();
  begin  
   if(alu_bus==0) fz=1;
   else fz=0;
  end
 endtask
 
 task flagC();
  begin  
    if (alu_bus < w_out) fc=1;
    else fc=0; 
  end
 endtask 
  
///////////////////////////////////////////
//////////// INSTRUCCIONES ////////////////
///////////////////////////////////////////
  
/////////////////////////////
//////Orientadas a byte//////
/////////////////////////////
 task addwf();
  begin
    alu_bus= w_out + alu_in;  
    flagZ();
    flagC();
  end
 endtask 
  
 task andwf();
  begin
    alu_bus= w_out & alu_in;  
    flagZ();
  end
 endtask 
  
 task clrf();
  begin
    alu_bus= 0;  
    flagZ();
  end
 endtask 
  
 task clrw();
  begin
    alu_bus= 0;  
    flagZ();
  end
 endtask 

 task comf();
  begin
    alu_bus= ~alu_in;  
    flagZ();
  end
 endtask 
   
 task decf();
  begin
    alu_bus= alu_in -1;  
    flagZ();
  end
 endtask  
  
 task decfz();
  begin
    alu_bus= alu_in -1; 
    flagZ();
  end
 endtask  
   
 task incf();
  begin
    alu_bus= alu_in +1;  
    flagZ();
  end
 endtask 
  
 task incfz();
  begin
    alu_bus= alu_in +1;  
    flagZ();
  end
 endtask 
  
 task movf();
 begin
    alu_bus= alu_in;  
  end
 endtask
  
 task movwf();
  begin
    alu_bus= w_out;  
  end
 endtask 
  
 task nop();
    alu_bus=alu_in;   
 endtask
  
 task rfl();
    alu_bus= alu_in<<1;   
    flagC();
 endtask 
  
  task rff();
    alu_bus= alu_in>>1;  
   flagC();
 endtask  
  
 task xorwf();
  begin
    alu_bus= w_out ^ alu_in;  
    flagZ();
  end
 endtask  
  
/////////////////////////////
//////Orientadas a bit //////
/////////////////////////////
 task bcf();
   reg [2:0] b;
   reg [7:0] mask;
   begin
	 b = ir_bus[7:5];
     mask = ~(1<<b);
     alu_bus = alu_in & mask;
   end
 endtask
  
 task bsf();
   reg [2:0] b;
   reg [7:0] mask;
   begin
     b = ir_bus[7:5];
     mask = (1<<b);
     alu_bus = alu_bus | mask;
   end
 endtask

/////////////////////////////
//////Literal y control//////
/////////////////////////////
 task andlw();
   begin
     alu_bus= w_out & alu_in;  
     flagZ();
   end
 endtask 
  
 task call();
   begin
     alu_bus = alu_in; 
   end
 endtask
  
 task retlw();
   begin
     alu_bus = alu_in; 
   end
 endtask
  
 task movlw();
   begin
      alu_bus = alu_in;
   end
 endtask
  
 task goto();
   begin
      alu_bus = alu_in;
   end
 endtask 
   
 task xorlw();
   begin
      alu_bus= w_out ^ alu_in;  
      flagZ();
   end
  endtask 

endmodule