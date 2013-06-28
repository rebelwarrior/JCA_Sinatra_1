#Api

##¿Que es un Api?

Un **Api** (Application Program Interface) es basicamente un interface que permite al programa comunicarse con otros programas. 

Tomemos por ejemplo una página de web. El interface del usuario (**UX**, User Interface) es lo que uno ve. Pero la computadora no puede ver la página, solo la data y tendria que analizar la pagina *entera* para saber *una* sola cosa sobre esta.

---

###Piping
Para entender el concepto de un API hay que entender el poder y el concepto de los '**pipes**' o sea el usar el 'output' de un programa como el 'input' de otro. Digamos que uno quiere listar el contenido de un directorio (con `ls` o `dir` si es Windows) pero hay tantos archivos que pasan tan rápido que uno no los puede ver. ¿Como uno hace? Tambien hay otro programa que toma insumo y lo divide en paginas que caben dentro del tamaño del terminal llamado `less`. Uno pude mandarle el 'output' del primer programa (`ls` o `dir`) a el segundo asi:

>`ls | less`  
(`dir | less`) 

y tan sencillo como eso funciona. 

Esto solo funciona porque el 'output' de un programa puede connectar con el 'input' de otro. Osea un programa puede communicarse con el otro. En este caso solo en una direccion. ¿Pero imaginense si se puede comunicar en ambas direciones?  Eso precisamente es lo que permite un API.

---
 
Volviendo a la página web. Si esta página tuviera un API no tengo que usar el UX normal puedo pedir el contenido directamente, programa a programa. Digamos que la pagina tiene una tabla con los muestreos de playa y yo quiero pedirolo directamente de otro website para crear una grafica. En vez de recibir un enjambre de HTML puedo conseguir la data en una manera útil para procesarla directamente (como en JSON, JavaScript Object Notation) y tambien puedo activamente **interactuar** con la pagina directamente desde otro programa. 

---


