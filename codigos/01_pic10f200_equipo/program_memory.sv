// Módulo memoria de programa
module program_memory(pc_out, program_bus);   
  // I/O declaration
  input  [8:0]  pc_out;                   //Dirección.
  output [12:0] program_bus;              //Palabra. 
  
  reg [12:0] program_regs[512];           //Celdas de almacenamiento.
    
  // Código de instrucciones. 
  initial begin                           //Código de operación del programa. 
    /*
    //MOVLW y ANDLW
    program_regs[0] <= 'b1100_0010_0111;  //movlw 7
    program_regs[1] <= 'b1110_0000_1000;  //andlw w con 8
    program_regs[2] <= 'b1100_0000_0011;  //movlw 3
    program_regs[3] <= 'b1110_0000_1101;  //andlw w con 13
    */
    
    /*
    //MOVLW MOVWF y MOVF
    program_regs[0] <= 'b1100_0100_0001;  //movlw 65 
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b1100_0000_1111;  //movlw f  
    program_regs[3] <= 'b0010_0000_1000;  //movf celda 8 a W.
    program_regs[4] <= 'b1100_0000_0011;  //movlw 3 
    */
    
    /*
    //INCF MOVFW
    program_regs[0] <= 'b0010_1010_1001;  //incf 0x09h
    program_regs[1] <= 'b0010_1010_1001;  //incf 0x09h
    program_regs[2] <= 'b0010_1010_1001;  //incf 0x09h
    program_regs[3] <= 'b0010_1010_1001;  //incf 0x09h
    program_regs[4] <= 'b0010_0000_1001;  //movf celda 9 a W.
    */
    
    /*
    //MOVLW MOVWF DECF MOVFW
    program_regs[0] <= 'b1100_0000_0101;  //movlw 5 
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b0000_1110_1000;  //decf 0x08h
    program_regs[3] <= 'b0000_1110_1000;  //decf 0x08h
    program_regs[4] <= 'b0010_0000_1000;  //movf celda 8 a W.
    */
   
   /* //MOVLW MOVWF MOVLW ADDWF
    program_regs[0] <= 'b1100_0000_0100;  //movlw 4
    program_regs[1] <= 'b0000_0010_1010;  //movwf w celda 10
    program_regs[2] <= 'b1100_1111_1111;  //movlw 255
    program_regs[3] <= 'b0001_1100_1010;  //addwf w + la celda 10 ponerlo en W
   */
   
    /*
    //MOVLW MOVWF MOVLW ANDWF
    program_regs[0] <= 'b1100_0000_0011;  //movlw 3
    program_regs[1] <= 'b0000_0010_1010;  //movwf w a celda 10
    program_regs[2] <= 'b1100_0000_0101;  //movlw 5
    program_regs[3] <= 'b0001_0100_1010;  //andwf w and la celda 10 ponerlo en W
    */
    
    /*
    //MOVLW MOVWF MOVLW XORWF
    program_regs[0] <= 'b1100_0000_0011;  //movlw 3
    program_regs[1] <= 'b0000_0010_1010;  //movwf w a celda 10
    program_regs[2] <= 'b1100_0000_0101;  //movlw 5
    program_regs[3] <= 'b0001_1000_1010;  //xorwf w xor la celda 10 ponerlo en W
    */
    
    /*
    //MOVLW MOVWF CLRF MOVFW 
    program_regs[0] <= 'b1100_0000_0011;  //movlw 3
    program_regs[1] <= 'b0000_0010_1010;  //movwf w a celda 10
    program_regs[2] <= 'b0000_0110_1010;  //clrf celda 10
    program_regs[3] <= 'b0010_0000_1010;  //movf celda 10 a W.
    */
    
    /*
    //MOVLW CLRW MOVlW CLRW 
    program_regs[0] <= 'b1100_0000_0111;  //movlw 7
    program_regs[1] <= 'b0000_0100_0000;  //clrw
    program_regs[2] <= 'b1100_0000_0011;  //movlw 3
    program_regs[3] <= 'b0000_0100_0000;  //clrw
    */
    
    /*
    //MOVLW MOVWF COMF MOVFW 
    program_regs[0] <= 'b1100_0000_0011;  //movlw 3
    program_regs[1] <= 'b0000_0010_1010;  //movwf w a celda 10
    program_regs[2] <= 'b0010_0110_1010;  //comf celda 10 guarda en f
    program_regs[3] <= 'b0010_0000_1010;  //movf celda 10 a W.
    */
   
    /*
    //MOVLW GOTO
    program_regs[0] <= 'b1100_0000_0011;  //movlw 3
    program_regs[1] <= 'b1010_0001_0100;  //GOTO 20
    program_regs[2] <= 'b1100_0000_1111;  //movlw f
    program_regs[20] <='b1100_0000_0111;  //movlw 7
    program_regs[21] <='b1100_0000_0010;  //movlw 2
    */
    
    /*
    //MOVLW MOVWF DECFZ MOVFW
    program_regs[0] <= 'b1100_0000_0010;  //movlw 1
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b0010_1110_1000;  //decfsz 0x08h guardar en f
    program_regs[3] <= 'b0010_1110_1000;  //decfsz 0x08h guardar en f
    program_regs[5] <= 'b1100_0000_0010;  //movlw 2
    program_regs[6] <= 'b1100_0000_0011;  //movlw 3
    */
  
    /*
    //MOVLW MOVWF INCFZ MOVFW
    program_regs[0] <= 'b1100_1111_1110;  //movlw 254
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b0011_1110_1000;  //incfz 0x08h guardar en f
    program_regs[3] <= 'b0011_1110_1000;  //incfz 0x08h guardar en f
    program_regs[5] <= 'b1100_0000_0011;  //movlw 3
    program_regs[6] <= 'b1100_0000_0001;  //movlw 1
    */
    
    //MOVLW MOVWF BCF INCF MOVF CLRW //////////////
    program_regs[0] <= 'b1100_1111_1111;  //movlw 255
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b0100_1100_1000;  //BIT CLEAR 6
    program_regs[3] <= 'b0010_1010_1000;  //incf 0x08h
    program_regs[4] <= 'b0010_0000_1000;  //movf celda 8 a W.
    program_regs[5] <= 'b0000_0100_0000;  //clrw
    program_regs[6] <= 'b0000_0110_1000;  //clrf celda 8
    
    /*
    //MOVLW MOVWF BSF MOVFW
    program_regs[0] <= 'b1100_1000_0000;  //movlw 128
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b0101_0100_1000;  //BIT SET 2
    program_regs[3] <= 'b0010_0000_1000;  //movf celda 8 a W.
    */
    
   /*
    //CALL MOVLW RETLW MOVLW //////
    program_regs[0]  <= 'b1001_1000_0000;  //call pc=0x80h
    program_regs[1]  <= 'b1100_0000_0111;  //movlw 7
    program_regs[2]  <= 'b1100_0000_1111;  //movlw f
    program_regs[128]<= 'b1100_0000_0001;  //movlw 1
    program_regs[129]<= 'b1000_0000_0011;  //retlw 3
    */
    
    /*
    //MOVLW MOVWF NOP NOP RLF
    program_regs[0] <= 'b1100_0000_0011;  //movlw 3 
    program_regs[1] <= 'b0000_0010_1000;  //movwf w celda 8
    program_regs[2] <= 'b0000_0000_0000;  //NOP
    program_regs[3] <= 'b0011_0100_1000;  //RLF
    program_regs[4] <= 'b0011_0000_1000;  //RFF
    */
  
  end
  assign program_bus = program_regs[pc_out];
endmodule