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

##Importancia de los API

Jeff Bezos el presidente de Amazon se dio cuenta que los API eran super importantes y mando este memo interno a los programadores:

>All teams will henceforth expose their data and functionality through service interfaces [APIs]. Teams must communicate with each other through these interfaces. There will be no other form of interprocess communication allowed: no direct linking, no direct reads of another team’s data store, no shared-memory model, no back-doors whatsoever. The only communication allowed is via service interface calls over the network.It doesn’t matter what technology they use. HTTP, Corba, Pubsub, custom protocols—doesn’t matter. [Amazon CEO Jeff] Bezos doesn’t care. All service interfaces, without exception, must be designed from the ground up to be externalizable. That is to say, the team must plan and design to be able to expose the interface to developers in the outside world. No exceptions. Anyone who doesn’t do this will be fired. [via Steve Yegge](https://plus.google.com/112678702228711889851/posts/eVeouesvaVX)

¿Por qué Bezos manda este memo en 2002? Porque se da cuenta que los API son la fundacion de lo que se llama ahora Service Oriented Architechture (SOA) y esto permite la **modulización** de servicios.

Vamos a ver los beneficios de construir software con API como punto de partida de diseño:

## Beneficios
1. Impone la modularizacion del programa esto crea:
  - independencia de partes
  - habilidad de crecer o cambiar modularmente en vez de el sistema entero
  - usar sistemas y lenguages diferentes en diferentes modulos
2. Permite que se unan servicios externos (Por ejemplo la applicacion de iPhone de Amazon)
3. Facilita debugging pues un bug en una parte del sistema no puede contaminar otro sistema.

---





