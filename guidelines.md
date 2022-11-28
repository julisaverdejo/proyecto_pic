# Guidelines para proyecto PIC10F200 en verilog



## 1. Reglas de sintaxis

1. Utilizar la sintaxis de verilog de antes del 2001. Esto con el objetivo de poder instancias los módulos copiando y pegando la primera línea del módulo y únicamente modificando las señales a conveniencia.
2. Comentar donde inician las entradas y salidas y donde inicia la descripción del módulo.
3. Cuando se generen registro de salida, utilizar un registro auxiliar en lugar de agregar la palabra reservada `reg` posterior a `output`.
4. Utilizar 1 tabulador en lugar de espacios, en su defecto utilizar 4 espacios.
5. No escribir `begin` en una línea sola.
6. Para las inicializaciones con `for` se pueden omitir las sentencias `begin` y `end` si solo es un comando.
7. Todas las señales de entrada y salida serán escritas en minúsculas.
8. Las señales auxiliares también deben ser escritas con minúsculas.
9. Los nombres de los módulos deben ser nemónicos y escribirse con minúsculas y guiones bajos.



## 2. Convención de señales

1. Al describir un módulo siempre empezar con las entradas y después con las salidas.
2. Si se trata de un módulo secuencial siempre comenzar con la señal `clk` y `rst`.
3. Posteriormente las señales de control y finalmente entrada de datos y salidas.



| Nombre de señal        | Abreviación |
| ---------------------- | ----------- |
| Señal de reloj         | `clk`       |
| Señal de reset         | `rst`       |
| Cualquier habilitación | `en`        |

