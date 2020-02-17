# CIU-2-Generador3D
### Autor: Víctor Herrera Delgado  

Programa que a partir de un dibujo hecho por el usuario genera una figura 3D.

## Introducción 
El programa desarrollado permite al usuario marcar puntos haciendo click en la mitad derecha de la pantalla. Cada uno de los puntos será un vértice en cada cara dibujada en la figura 3D, de tal manera que el resultado final sea el resultado de rotar las líneas que unen los puntos vértices marcados alrededor del eje Y central en la pantalla. 
Una vez obtenida la figura 3D, el usuario puede moverla y rotarla para verla mejor.

## Instrucciones
Si bien en la pantalla de dibujo 2D se muestran las instrucciones a la izquierda, las repasaremos aquí.
### En pantalla 2D:
- Click izquierdo: Añade un vértice al dibujo en 2D. Si se dibujó un punto anteriormente se mostrará la línea que los une y que luego formará la superficie de la figura 3D.
- Click derecho: Borra el último punto creado.


- Tecla Enter : Crea la figura 3D a partir del dibujo en 2D.
- Tecla R : Reinicia el dibujo.

### En pantalla 3D:
- Mover el ratón: Mueve la figura en el espacio disponible.
- Flechas de control: UP y DOWN rotan la figura hacia arriba o hacia abajo respectivamenteotan la figura hacia la izquierda y la derecha respectivamente.
- Tecla D: Devuelve la vista 3D a su vista inicial.

- Tecla A: Vuelve a la pantalla 2D con posibilidad de modificar el dibujo.
- Tecla R: Reinicia el dibujo volviendo a la pantalla 2D.


## Decisiones
Se consideró buena idea dar suficientes opciones al usuario para poder modificar el dibujo una vez empezado o una vez hecha la figura 3D. También se consideró que la traslación y rotación de la figura en 3D daría una mayor libertad al usuario para ver la figura.
Por último, dado que el dibujo se haría solo en una mitad de la pantalla se optó por inhabilitar la otra y usarla para proporcionarle un manual de uso al usuario.


## Funcionamiento
![](Practica2.gif)

## Herramientas

Conversor de video a gif:
https://hnet.com/video-to-gif/

Grabación del programa:
https://obsproject.com/
