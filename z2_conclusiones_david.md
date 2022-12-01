
El analizar y crear un procesador utilizando un lenguaje de descripción de hardware como Verilog fue una buena experiencia para aprender y mejorar mis habilidades de programación en este lenguaje. Además, con este proyecto de alguna forma aprendí y obtuve una mejor noción acerca del funcionamiento de cada uno de los bloques básicos que participan en el ciclo de ejecución de un procesador.

Para la elaboración del proyecto primero fue necesario estudiar la arquitectura del procesador y posteriormente el ciclo de ejecución de este. El punto central fue abordar cada uno de los bloques lógicos por separado con el fin de comprender su importancia y contribución en el sistema.

Al inicio nos faltó una mejor organización como equipo a la hora de asignar los nombres de las señales de control, sin embargo, esto pronto fue solucionado y optamos por definir solo señales de control con letra minúscula y emplear una estructura organizada para la declaración de las variables de cada bloque.

Durante el desarrollo del proyecto nuestra idea se centró en que cada uno de los bloques elaborados debía ser sometido a pruebas, mediante un techbench, esto con el fin de corroborar el correcto funcionamiento de cada bloque.

Cuando terminamos todos los módulos por separado, estábamos conscientes que sería complicado tratar de unir todos los bloques en un solo programa sin realizar pruebas, por ello, elegimos unir los bloques paso por paso, siempre agregando un nuevo módulo y haciendo pruebas para verificar la correcta comunicación entre los módulos y evitar resultados inesperados.  

El ultimo elemento programado fue la unidad de control (decoder) en la cual mediante un diagrama de estados establecimos el ciclo de operación del procesador, para cumplir con la cuadratura de los 4 ciclos de reloj por cada instrucción.

En general fue todo un reto comprender la rutina de ejecución de cada una de las instrucciones, pero al final logramos completarlo. Lo mas complicado del proyecto fue unir los módulos, elaborar la unidad de control y una de las cuestiones más complejas fue elaborar las instrucciones de salto y la instrucción que utiliza la pila para ejecutar una rutina.

En general, aunque el PIC10 es un procesador sencillo, contiene una buena cantidad de bloques lógicos y secuenciales con diversas señales de control. Para este tipo de proyectos se requiere de una muy buena organización como equipo a la hora de repartir los bloques y además es necesario tener paciencia a la hora de programar y unir los bloques.

Al proyecto aporte la programación de diversos bloques de programación y además me encargue de la unión de los bloques lógicos en EDA playground y la programación de la unidad de control.

Apoye a mis compañeros Jomahi y Pedro en ciertos bloques de su procesador PIC16F84A y a mi compañero Sergio en la comprensión del funcionamiento de la ALU de su procesador.

Este tipo de proyectos permiten mejorar las habilidades de programación en cierto lenguaje y la lógica para el desarrollo e implementación de un sistema, quizá en futuros proyectos en algún trabajo sea necesario elaborar algún sistema digital en Verilog y con los conocimientos adquiridos durante el curso tendré las herramientas para poder abordarlo y realizarlo.