# Diseño de arquitectura de PIC10F200 en Verilog

Autores:

1. Julisa Verdejo Palacios
2. Jose David Rodríguez Muñoz
3. Oscar Iván Ramírez Medina
4. Eduardo Juárez Mendoza

## 1. Características del PIC

El PIC10F200 es un dispositivo de bajo costo, alto rendimiento, de 8 bits, con memoria Flash basada en CMOS desarrollado por Microchip Technology. Este microcontrolador emplea una arquitectura **RISC** (Reduce Instruction Set Computing). El conjunto de instrucciones es fácil de usar y fácil de recordar lo cual reduce significativamente el tiempo de desarrollo.

Estos dispositivos utilizan una arquitectura **Harvard** en donde el acceso al programa y la memoria de datos es por buses separados. Esto aumenta el ancho de banda sobre arquitecturas tradiciones de von Neumann donde el programa y la memoria de datos utilizan el mismo bus.

### 1.1. Especificaciones

* Cuenta con 33 instrucciones de palabra simple (Single-Word).
* Todas las instrucciones toman un ciclo de instrucción excepto las instrucciones de salto que toman dos ciclos.
* Las instrucciones son de 12 bits de ancho.
* Cuenta con un stack en hardware de 2 niveles de profundidad.
* El ancho del data path es de 8 bits. 
* 8 registros de de función especial en hardware.
  * INDF, TMR0, PCL, STATUS, FSR, OSCCAL, GPIO, CMCONC0
* 16 registros de propósito general.
* Velocidad de operación
  * Reloj interno de 4 MHz.
  * Ciclo de instrucción de 1 microsegundo. 

### 1.2. Periféricos

* Cuenta con 4 pines I/O:
  * 3 pines I/O con control individual de dirección.
  * 1 pin de solo lectura.
* Contador de 8 bits (TMR0) con prescalador programable de 8 bits. 
* Un comparador:
  * Referencia de voltaje absoluta interna.
  * Ambas entradas del comparador externamente visibles.
  * Salida del comparador externamente visible.

### 1.3. Resumen de especificaciones

En la Tabla 1 se muestran las pequeñas variaciones que hay en los distintos PICs de la familia 10F. Estas son:

* Mayor memoria de programa (Flash).
* Mayor memoria de datos.
* Comparador opcional.
![[A1_especificaciones.png|500]]
<img src="imagenes\A1_especificaciones.png" alt="A1_especificaciones" style="zoom:60%;" />
[imagen](imagenes/A0_pinout.png)
**Tabla 1: Comparación de especificaciones, extraída de [1]**.



### 1.4. Diagrama de pines

En la Figura 1 se muestra el diagrama de pines PDIP (Plastic Dual In-Line Package) del PIC. La única variación que hay entre los diferentes PICs de esta familia es que los pines 3,4,5 se pueden configurar como comparador si se tiene disponible, de otra manera se utilizan como entradas o salidas. Se tienen dos pines para la alimentación, 2 y 7 respectivamente y los pines 1 y 6 no se utilizan. El pin 8 se puede configurar únicamente como entrada de ser necesario o funciona normalmente como reset.

<img src="imagenes\A0_pinout.png" alt="A0_pinout" style="zoom:50%;" />

**Figura 1: Pinout, extraído de [1]**.

### 1.5. Aplicaciones

Los dispositivos PIC10F200 se adaptan a aplicaciones que van desde dispositivos de cuidado personal y sistemas de seguridad hasta transmisores/receptores remotos de baja potencia. La tecnología Flash hace que la personalización de los programas de aplicación sea extremadamente rápida y cómoda. Su empaquetado de tamaño reducido hace que estos microcontroladores sean ideales para aplicaciones con limitaciones de espacio. El bajo costo, bajo consumo de energía, alto rendimiento, facilidad de uso y flexibilidad de I/O hacen que sean muy versátiles incluso en áreas donde no se ha considerado antes el uso de microcontroladores (funciones de temporizador, lógica y PLD en sistemas más grandes y aplicaciones de coprocesador).



### 1.6. Data path

<img src="imagenes\A2_datapath.png" alt="A2_datapath" style="zoom:80%;" />

**Figura 2: Data Path, extraído de [1]**.



### 1.7. Organización de la memoria de datos

La memoria de datos esta organizada en el mapa de registros de la Figura 3. Las direcciones están es hexadecimal y van desde 00h hasta 1Fh. Las primeras 8 direcciones de la memoria de datos esta reservada para algunos de los registros de función especial, los cuales son: 

* **INDF:**  Indirect Data Addresing.

* **TMR0:** Este registro se utiliza para el funcionamiento del periférico contador de 8 bits.   
* **PCL:** Registro de contador de programa (Program Counter). Almacena la dirección de la próxima instrucción a ejecutarse en la memoria de programa. El valor del Program Counter se incrementa en uno cada ciclo de instrucción, a menos que una instrucción cambie su valor.
* **STATUS:** Este registro contiene el estado de la aritmética del ALU. Por ejemplo, en este registro el bit **DC** que indica cuando ocurre un desbordamiento en las operaciones de suma y resta.
* **FSR**: (File Select Register). Se utiliza en combinación con el registro INDF para hacer direccionamiento indirecto.
* **OSCCAL:** Registro de calibración del oscilador. Es utilizado para calibrar la precisión interna del oscilador de 4 MHz, Contiene 7 bits de calibración. El valor de calibración debe leerse antes de borrar el dispositivo para que pueda programarse correctamente posteriormente.
*  **GPIO:** Solo los últimos 4 bits de este registro se utilizan. GP0, GP1,GP2 se pueden configurar como estradas o salidas utilizando el registro TRIS (Tristate register), GP3 puede configurarse solo como entrada. El registro GPIO nos permite leerlo para conocer el estado de las entradas de los pines o modificarlo para poner a 1 o 0 los pines configurados como salida.
* **CMCONC0:** Este registro controla la operación del comparador.

<img src="imagenes\A4_register_file_map.png" alt="A4_register_file_map" style="zoom:70%;" />

**Figura 3: Mapa de registros de la memoria de datos, extraído de [1].**



### 1.8. Memoria del programa

<img src="imagenes\A3_program_memory_map.png" alt="A3_program_memory_map" style="zoom:80%;" />

**Figura 4: Memoria del programa, extraído de [1].**

## 2. Set de instrucciones

Las instrucciones del PIC se dividen en tres categorías básicas:

* Operaciones orientadas a byte.
* Operaciones orientadas a bit.
* Operaciones de literal y control.

Cada instrucción del PIC se divide en dos partes, el **opcode**, el cual especifica el tipo de instrucción y un **operando**.



<img src="imagenes\A5_instruction_format.png" alt="A5_instruction_format" style="zoom:60%;" />

**Figura 5: Mapa de registros de la memoria de datos, extraído del datasheet [1].**



<img src="imagenes\A6_opcode_description.png" alt="A6_opcode_description" style="zoom:80%;" />

**Tabla 2: Descripción de campos de opcode,extraído del datasheet [1]**



## 4. Códigos

### 4.1. Módulo RAM

- Código
  * **Descripción:** Módulo RAM de un solo puerto con reset síncrono e inicialización a ceros con prioridad de escritura.


```verilog
module ram_reg(clk, rst, we, addr, din, dout);
    
	// I/O declaration
	input  clk;
	input  rst;
	input  we;
	input  [4:0] addr;
	input  [7:0] din;
	output [7:0] dout;		
				
	// Description
	reg [7:0] ram[23:0];
	reg [4:0] addr_reg;
	integer i;
	
	always @ (posedge clk) begin
		if (rst) begin
			for(i=0; i<24; i=i+1)
				ram[i] <= 0;
		end
		if (we) begin
			ram[addr] <= din;
		end
		addr_reg <= addr;
	end
	
	assign dout = ram[addr_reg];
endmodule 
```

**Código:**

 - Testbench

```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_ram_reg; 
    
	// Aux signals for testbench
	reg  clk;
	reg  rst;
	reg  we;
	reg  [4:0] addr;
	reg  [7:0] din;
	reg  [7:0] dout;	
	
	// Instantiation DUT (Device Under Test)
	ram_reg DUT (clk, rst, we, addr, din, dout);	
	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	// Initialitation and Reset sequence
	initial begin
		clk = 0; rst = 0; we = 0; addr = 5'd0; din  = 8'd1; #period;
		rst = 1; #period;
		rst = 0; #period;
	end
    
    // 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period 
	always #10 clk = ~clk; 
		
	initial begin	
		#(period*4);
		
		// Write test
		addr = 5'd0; din  = 8'd1; we = 1; #period;
		we = 0; #period;   
		
		addr = 5'd4; din  = 8'd2; we = 1; #period;
		we = 0; #period;
		
		// Read test
		addr = 5'd0; #(period*2); 
		addr = 5'd4; #(period*2); 
		addr = 5'd8; #(period*2); 
	end
endmodule
```

**Código:**

 - Esquemático

 - Simulación

<img src="imagenes\B0_ram_simu.png" alt="B0_ram_simu" style="zoom:90%;" />

 - Implementación
   - Status: Pendiente


---

### 4.2. Divisor de frecuencia

- Código
  * **Descripción:** Divisor de frecuencia basado en un contador con reset automático y un flip-flop a la salida con comparador y reset. La formula para calcular `div_val` es `div_val` = (t*f_fpga)/2 -1


```verilog
module clk_div(clk, rst, slow_clk);
	
	// I/O declaration
	input  clk;
	input  rst;
	output slow_clk; 
	
	// Descrition
	localparam div_val = 50000000-1;
	integer	   count_val = 0;
	reg temp_clk = 0;
	
	// Simple Counter with auto reset
	always @(posedge clk) begin
		if( ( count_val == div_val ) || rst)
			count_val <= 0;	
		else
			count_val <= count_val + 1;		
	end
	
	// Comparator with flip-flop logic
	always @(posedge clk) begin
		if (rst)
			temp_clk <= 0;
		else if (count_val == div_val)
			temp_clk <= ~temp_clk;
		else
			temp_clk <= temp_clk;	
	end	  
    
	assign slow_clk = temp_clk;
endmodule
```

**Código:**

 - Testbench

```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_clk_div; 		
	
	// Aux signals for testbench
	reg  clk;
	reg  rst;
	reg  slow_clk; 
	
	// Instantiation DUT (Device Under Test)
	clk_div DUT (clk, rst, slow_clk);	
	// Time period = 20 * timescale = 20 * 1ns = 20ns
	localparam period = 20;
	
	// Reset sequence
	initial begin
		clk = 0; rst = 0; #period;
		rst = 1; #period;
		rst = 0; #period;
	end	   
    
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
endmodule
```

**Código:**

 - Esquemático

 - Simulación

<img src="imagenes\B3_clk_div_silu.png" alt="B3_clk_div_silu" style="zoom:67%;" />

 - Implementación
   - Status: Completada


---

### 4.3. W Register 

 - Código
   * **Descripción:** W register como un simple flip-flop D con habilitación basado en la documentación oficial de Xilinx.


```verilog
module w_reg(clk, rst, en, din, dout);
    
	// I/O declaration
	input  clk;
	input  rst;
	input  en;
	input  [7:0] din;
	output [7:0] dout;
    
	// Descrition
	reg [7:0] d_reg;
	always @(posedge clk) begin
		if(rst)
			d_reg <= 0;
		else if (en)
			d_reg <= din;
	end
	assign dout = d_reg;
endmodule
```

**Código:**

 - Testbench

```verilog
// Time Unit = 1ns, precision = 100ps = 1/10 ns
`timescale 1 ns / 100 ps  
module tb_w_reg; 
	
	// Aux signals for testbench  
	reg  clk;
	reg  rst;
	reg  en;
	reg  [7:0] din;
	reg  [7:0] dout;
	
	// Instantiation DUT (Device Under Test)
	w_reg DUT (clk, rst, en, din, dout);;	
	
	localparam period = 20;
	
	//  Reset sequence
	initial begin
		clk = 0; rst = 0; en = 0; din = 8'd1; #period;
		rst = 1; #period;
		rst = 0; #period;
	end	   
	
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
		
	initial begin	
		#(period*4);
		
		// Load 
		din = 8'd1;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 8'd2;
		#(period*2);
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 8'd4;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
	end
endmodule
```

**Código:**

 - Esquemático
 - Simulación

<img src="imagenes\B4_w_reg_silu.png" alt="B4_w_reg_silu" style="zoom:80%;" />

 - Implementación
   - Status: Pendiente


---

### 4.4. Instruction Register (IR) 

 - Código

* **Descripción:** Instruction register como un simple flip-flop D con habilitación basado en la documentación oficial de Xilinx.

```verilog
module i_reg(clk, rst, en, din, dout);
	
	// I/O declaration
	input  clk;
	input  rst;
	input  en;
	input  [11:0] din;
	output [11:0] dout;
	
	// Descrition
	reg [11:0] d_reg;
	always @(posedge clk) begin
		if(rst)
			d_reg <= 0;
		else if (en)
			d_reg <= din;
	end
	
	assign dout = d_reg;
	
endmodule
```

**Código:**

 - Testbench

```verilog
`timescale 1 ns / 100 ps  
module tb_i_reg; 
	
	// Aux signals for testbench  
	reg  clk;
	reg  rst;
	reg  en;
	reg  [11:0] din;
	reg  [11:0] dout;
	
	// Instantiation DUT (Device Under Test)
	i_reg DUT (clk, rst, en, din, dout);;	
	
	localparam period = 20;
	
	//  Reset sequence
	initial begin
		clk = 0; rst = 0; en = 0; din = 12'd1; #period;
		rst = 1; #period;
		rst = 0; #period;
	end	   
	
	// 50 MHz clock (10 * 1ns * 2) with 50% duty-cycle 	 20 ns period
	always #10 clk = ~clk;  
		
	initial begin	
		#(period*4);
		
		// Load 
		din = 12'd1;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 12'd2;
		#(period*2);
		en = 1; #period;
		en = 0; #period;
		#(period*2);
		
		// Load 
		din = 12'd4;
		en = 1; #period;
		en = 0; #period;
		#(period*2);
	end
endmodule
```

**Código:**

 - Esquemático

 - Simulación

<img src="imagenes\B5_i_reg_silu.png" alt="B5_i_reg_silu" style="zoom:67%;" />

 - Implementación
   - Status: Pendiente


---





### 4.2. Program Counter

#### - Código

* **Descripción:** 

```verilog
// En modificación
```

**Codigo:**

#### - Testbench

```verilog
// En modificación
```

**Codigo:**

#### - Esquemático

#### - Simulación

### 4.3. ALU

#### - Código

* **Descripción:** 

```verilog
// Code your design here
module alu(
	input [7:0] A,B,  // ALU 8-bit Entradas                 
	input [3:0] ALU_Sel,// ALU Selección operación
	output [7:0] ALU_Out, // ALU 8-bit Salidas
	output CarryOut // Indicador Carry Out 
);
	reg [7:0] ALU_Result;
	wire [8:0] tmp;
	assign ALU_Out = ALU_Result; // Salida ALU 
	assign tmp = {1'b0,A} + {1'b0,B};
	assign CarryOut = tmp[8]; // Indicador Carryout}
	
    always @(*) begin
        case(ALU_Sel)
        4'b0000: // Suma
           ALU_Result = A + B ; 
        4'b0001: // Rsta
           ALU_Result = A - B ;
        4'b0010: // Multiplicación
           ALU_Result = A * B;
        4'b0011: // División
           ALU_Result = A/B;
        4'b0100: // Desplazamiento a la izquierda
           ALU_Result = A<<1;
         4'b0101: // Desplazamiento a la derecha 
           ALU_Result = A>>1;
         4'b0110: // Girar izquierda
           ALU_Result = {A[6:0],A[7]};
         4'b0111: // Girar derecha
           ALU_Result = {A[0],A[7:1]};
          4'b1000: //  AND
           ALU_Result = A & B;
          4'b1001: //  OR
           ALU_Result = A | B;
          4'b1010: //  XOR 
           ALU_Result = A ^ B;
          4'b1011: //  NOR
           ALU_Result = ~(A | B);
          4'b1100: // NAND 
           ALU_Result = ~(A & B);
          4'b1101: // XNOR
           ALU_Result = ~(A ^ B);
          4'b1110: // Comparación mayor
           ALU_Result = (A>B)?8'd1:8'd0 ;
          4'b1111: // Comparación resultado   
            ALU_Result = (A==B)?8'd1:8'd0 ;
          default: ALU_Result = A + B ; 
        endcase
    end
endmodule
```

**Codigo:**

#### - Testbench

```verilog
// Code your testbench here
// or browse Examples
 `timescale 1ns / 100ps  

module tb_alu;
//Inputs
 reg[7:0] A,B;
 reg[3:0] ALU_Sel;

//Outputs
 wire[7:0] ALU_Out;
 wire CarryOut;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            A,B,  // ALU 8-bit Entradas                 
            ALU_Sel,// ALU Selección
            ALU_Out, // ALU 8-bit Salida
            CarryOut // Indicador Carry Out
     );
    initial begin
    // mantener el estado de reinicio durante 100 ns.
      A = 8'h0A;
      B = 4'h02;
      ALU_Sel = 4'h0;
      
      for (i=0;i<=15;i=i+1)
      begin
       ALU_Sel = ALU_Sel + 8'h01;
       #10;
      end;
      A = 8'hF6;
      B = 8'h0A;
    end

initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
 end  
endmodule
```

**Codigo:**

#### - Esquemático

Por agregar

#### - Simulación

<img src="imagenes\B2_alu_simu.png" alt="B2_alu_simu" style="zoom:80%;" />



### 4.3. MUX

#### - Código

* **Descripción:** 

```verilog
module alu_mux_2_to_1 (RAM, SFR, SEL, alu);
input [7:0]RAM, SFR;
input SEL;
output [7:0]alu;

assign alu=SEL?RAM:SFR; //SEL=1(RAM) & SEL=0(SFR)

endmodule
```

**Codigo:**

#### - Testbench

```verilog
module testbench();
  reg [7:0]RAM, SFR;
  reg SEL;
  wire [7:0]alu;
  
  alu_mux_2_to_1 dut(RAM,SFR,SEL,alu);
  initial begin
    repeat(5) 
      begin
       RAM = $random;
       SFR = $random;
       SEL = $random;
      #2ns;
   	  end
  end
  initial begin
    $monitor("RAM=%b SFR=%b SEL=%b alu=%b", RAM,SFR,SEL,alu);
  end
endmodule

```

**Codigo:**

#### - Esquemático

<img src="imagenes\C2_mux_diagram.PNG" alt="C2_mux_diagram" style="zoom:100%;" />

#### - Simulación

<img src="imagenes\B2_mux_simu.PNG" alt="B2_mux_simu" style="zoom:120%;" />









#### 





### 4.n. Plantilla

#### - Código

* **Descripción:** 

```verilog

```

**Codigo:**

#### - Testbench

```verilog

```

**Codigo:**

#### - Esquemático

#### - Simulación





## 5. Implementación en FPGA

Se va a utilizar la tarjeta Basys3 que tiene las siguientes caracteristicas:

- Oscilador de 100 MHz
- Artix-7 XC7A35T1CPG236C
- 33,280 logic cells en 5200 slices (each slice contains four 6-input LUTs and 8 flip-flops)
- 16 user switches
- 16 user LEDs





```
## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]

## Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {rst}]

## LEDs
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {slow_clk}]
```







## 6. Definiciones

1. **Program Memory (Flash):** Es la memoria donde se guardan todas las instrucciones que se van a ejecutar en el microcontrolador, se mide en palabras (Words). Otra manera de verlo es como el código escrito por el programador convertido a hexadecimal el cual posteriormente se va a ejecutar. En el PIC10F200 es de 256x12 palabras. Cada instrucción es de 12 bits.
2. **Data Memory (SRAM):** Es la memoria que el programador tiene disponible para almacenar valores que se utilizarán dentro del código a ejecutar. Por ejemplo, el resultado de una suma se puede almacenar en alguno de los registros del data memory. En el PIC10F200 se tienen 16x8 registros disponibles. El PIC es un microcontrolador de 8 bits.
3. **Ciclo de instrucción:** Es la cantidad de ciclos de reloj que le toma al microcontrolador ejecutar una sola instrucción, en el caso del PIC10F200 son 4 ciclos de reloj. Como opera a 4 MHz cada instrucción toma 1 microsegundo, es decir (1/ 4 MHz)*4.
4. **GPIO:**  General Purpose Input/Output.
5. **PLD:** Programable Logic Devices.

## 7. Referencias

1. Datasheet del PIC en el siguiente [enlace](https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/40001239F.pdf).
2. Implementación del PIC10F200 en verilog por John Gulbrandsen en el siguiente [enlace](http://www.summitsoftconsulting.com/pic10ipcore.htm).
3. Implementación del PIC16F628A en verilog por kiwih en el siguiente [enlace](https://github.com/kiwih/pic16f-antastic).
4. Implementación del PIC16F84 en verilog por pawlex en el siguiente [enlace](https://github.com/pawlex/hdl.verilog.ipcore.pic.risc16f84).
5. Implementación del PIC16F628 en verilog por JeckSmit en el siguiente [enlace](https://github.com/JeckSmit/pic16f628).
6. Implementación del PIC16F1826 en verilog por OnlyAoiKunie en el siguiente [enlace](https://github.com/OnlyAoiKunie/PIC16f1826).
7. Implementación del PIC16C57 en verilog por hsyhsw en el siguiente [enlace](https://github.com/hsyhsw/PIC16C57).
8. Implementación del PIC16C5x en verilog por Michael A. Morris en el siguiente [enlace](https://github.com/MorrisMA/PIC16C5x).
9. Implementación del PIC16C84 en verilog por JeckSmit en el siguiente [enlace](https://github.com/JeckSmit/verilog-cpu-pic16C84).
10. Implementación del PIC16F84 en verilog por PJEstrada en el siguiente [enlace](https://github.com/PJEstrada/pic-16f84-verilog).
11. Implementación del PIC16F84 en verilog por sumio-morioka en el siguiente [enlace](https://github.com/sumio-morioka/cqpic).
12. Single Port RAM Intel [enlace](https://www.intel.com/content/www/us/en/support/programmable/support-resources/design-examples/horizontal/ver-single-port-ram.html)
13. Single Port RAM Xilinx [enlace](https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Single-Port-Block-RAM-with-Resettable-Data-Output-Verilog)
14. ALU de 4 bits para realizar 8 operaciones lógicas [enlace](https://programmerclick.com/article/8145851218/).
15. Verilog code for a simple ALU [enlace](https://verilogcodes.blogspot.com/2015/10/verilog-code-for-simple-alu.html).
16. Simple Flip-flop implementation [enlace](https://www.fpga4student.com/2017/02/verilog-code-for-d-flip-flop.html).
17. Archivo de restricciones para FPGA Basys3 [enlace](https://github.com/Digilent/digilent-xdc/blob/master/Basys-3-Master.xdc)
