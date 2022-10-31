# Diseño de arquitectura de PIC10F200 en Verilog

## 1. Características del PIC

El PIC10F200 es un dispositivo de bajo costo, alto rendimiento, de 8 bits, con memoria Flash basada en CMOS desarrollado por Microchip Technology. Este microcontrolador emplea una arquitectura **RISC** (Reduce Instruction Set Computing). El conjunto de instrucciones fácil de usar y fácil de recordar reduce significativamente el tiempo de desarrollo.

Estos dispositivos utilizan una arquitectura **Harvard** en donde el acceso al programa y la memoria de datos es por buses separados. Esto aumenta el ancho de banda sobre arquitecturas tradiciones de von Neumann donde el programa y la memoria de datos utilizan el mismo bus.

### 1.1. Especificaciones

* Cuenta con 33 instrucciones de palabra simple (Single-Word).
* Todas las instrucciones toman un ciclo de instrucción excepto las instrucciones de salto que toman dos ciclos.
* Las instrucciones son de 12 bits de ancho.
* Cuenta con un stack en hardware de 2 niveles de profundidad.
* El ancho del data path es de 8 bits. 
* 8 registros de de función especial en hardware.
  * Ejemplos
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

<img src="imagenes\A1_especificaciones.png" alt="A1_especificaciones" style="zoom:60%;" />

​       														**Tabla 1: Comparación de especificaciones**



### 1.4. Diagrama de pines

En la Figura 1 se muestra el diagrama de pines PDIP (Plastic Dual In-Line Package) del PIC. La única variación que hay entre los diferentes PICs de esta familia es que los pines 3,4,5 se pueden configurar como comparador si se tiene disponible, de otra manera se utilizan como entradas o salidas. Se tienen dos pines para la alimentación, 2 y 7 respectivamente y los pines 1 y 6 no se utilizan. El pin 8 se puede configurar únicamente como entrada de ser necesario o funciona normalmente como reset.

<img src="imagenes\A0_pinout.png" alt="A0_pinout" style="zoom:50%;" />

​																			                    **Figura 1: Pinout**



### 1.5. Aplicaciones

Los dispositivos PIC10F200 se adaptan a aplicaciones que van desde dispositivos de cuidado personal y sistemas de seguridad hasta transmisores/receptores remotos de baja potencia. La tecnología Flash hace que la personalización de los programas de aplicación sea extremadamente rápida y cómoda. Su empaquetado de tamaño reducido hace que estos microcontroladores sean ideales para aplicaciones con limitaciones de espacio. El bajo costo, bajo consumo de energía, alto rendimiento, facilidad de uso y flexibilidad de I/O hacen que sean muy versátiles incluso en áreas donde no se ha considerado antes el uso de microcontroladores (funciones de temporizador, lógica y PLD en sistemas más grandes y aplicaciones de coprocesador).



### 1.6. Data path

<img src="imagenes\A2_datapath.png" alt="A2_datapath" style="zoom:80%;" />

​                                                                                 **Figura 3: Data Path**





## 2. Set de instrucciones

Las instrucciones del PIC se dividen en tres categorías básicas:

* Operaciones orientadas a byte.
* Operaciones orientadas a bit.
* Operaciones de literal y control.

Cada instrucción del PIC se divide en dos partes, el **opcode**, el cual especifica el tipo de instrucción y un **operando**.



<img src="imagenes\A5_instruction_format.png" alt="A5_instruction_format" style="zoom:70%;" />



<img src="imagenes\A6_opcode_description.png" alt="A6_opcode_description" style="zoom:80%;" />









## 5. Definiciones

1. **Program Memory (Flash):** Es la memoria donde se guardan todas las instrucciones que se van a ejecutar en el microcontrolador, se mide en palabras (Words). Otra manera de verlo es como el código escrito por el programador convertido a hexadecimal el cual posteriormente se va a ejecutar. En el PIC10F200 es de 256x12 palabras. Cada instrucción es de 12 bits.
2. **Data Memory (SRAM):** Es la memoria que el programador tiene disponible para almacenar valores que se utilizarán dentro del código a ejecutar. Por ejemplo, el resultado de una suma se puede almacenar en alguno de los registros del data memory. En el PIC10F200 se tienen 16x8 registros disponibles. El PIC es un microcontrolador de 8 bits.
3. **Ciclo de instrucción:** Es la cantidad de ciclos de reloj que le toma al microcontrolador ejecutar una sola instrucción, en el caso del PIC10F200 son 4 ciclos de reloj. Como opera a 4 MHz cada instrucción toma 1 microsegundo, es decir (1/ 4 MHz)*4.
4. **GPIO:**  General Purpose Input/Output.
5. **PLD:** Programable Logic Devices.

## 6. Referencias

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

