<p align="center"><img src="https://alejandrohiguera.codes/POO2020/banner-ing.svg" width="100%"></p>

# Tetris en Processing (Java)

**Nombre:** Alejandro Higuera Castro

**Fecha de publicación:** 4 de octubre de 2020

**Elaborado para:** 2016375-Programación Orientada a Objetos

**Versión:** 1

## Contenido

1. [Introducción](#introducción)
2. [Objetivo](#objetivo)
3. [¿Cómo jugar?](#cómo-jugar)
4. [Puntuación](#puntuación)
5. [¿Cómo se desplaza nuestro Tetromino?](#desplazamiento-del-tetromino)
6. [¿Cómo se representa cada uno de los tetrominos activos?](#codificación-del tetromino-activo)
7. [¿Cómo se almacenan y leen los tetrominos que ya han caído?](#representación-de-los-tetrominos-que-han-caído)

## Introducción

Como primera entrega para el curso de Programación Orientada a Objetos desarrollé el juego de Tetris en Processing para Java bajo el paradigma de programación estructurada.

## Objetivo

- Repasar los conceptos de programación estructurada, según lo descrito en [Tetris - Wikipedia Article](https://en.wikipedia.org/wiki/Tetris).

## ¿Cómo jugar?

Una vez inicie el juego usted deberá manipular la posición de los tetrominos que caen en el tablero ayudado de las teclas ⬅️,⬇️,⬆️,➡️ de tal manera que pueda lograr el mayor número de filas con bloques llenos para su posterior eliminación y obtención de un puntaje alto.

- Presionar la tecla ⬅️, le permitirá mover el tetromino una celda hacia la izquierda.
- Presionar la tecla ⬇️, le permitirá aumentar la velocidad con que cae el tetromino.
- Presionar la tecla ⬆️, le permitirá rotar 90° 🔄 el tetromino mientras cae.
- Presionar la tecla ➡️, le permitirá mover el tetromino una celda hacia la derecha

## Puntuación
La puntuación se otorgará de acuerdo al número de líneas que se eliminan a la vez de acuerdo con la siguiente tabla:

| Número de líneas eliminadas al mismo tiempo 	| Puntaje 	|
|:-------------------------------------------:	|:-------:	|
|                      1                      	|   100   	|
|                      2                      	|   400   	|
|                      3                      	|   900   	|
|                  4 (Tetris)                 	|   1200  	|

## Desplazamiento del tetromino

Los desplazamientos se manejan bajo el Framerate por default de Processing (60 fps).

- **Desplazamiento hacia abajo** El tetromino se desplaza pixel a pixel.
- **Desplazamiento hacia la derecha o hacia arriba** El tetromino se desplaza celda a celda es decir de 40 pixeles en 40 pixeles.
- **Desplazamiento rápido hacia abajo** El tetromino se desplaza a una razón de 40 pixeles.

## Codificación del tetromino activo

El tetromino activo se representa mediante un entero equivalente a su representación en bits matricial de tamaño 4x4, donde 0 es un bloque vacío y 1 es un bloque lleno.

**Ejemplo:**
¿Cómo se representa el tetromino J con la rotación 3?

<p align="left"><img src="https://alejandrohiguera.codes/POO2020/tetromino.png" width="25%"></p>

1. Encontramos su representacion matricial 4x4
<p align="left"><img src="https://alejandrohiguera.codes/POO2020/matrix.png" width="20%"></p>

2. Codificamos su representacion matricial en binario mediante el formato Big Endian

0000 0000 0100 0111

3. Encontramos el entero equivalente al número binario

Así nuestro tetromino se representa como el número **71**. Esta representación la tome del codeSnippet enviado por el profesor Jean Pierre Charalambos.

## Representación de los tetrominos que han caído

Los tetrominos que ya han caído se almacenan en una variable global que es un arreglo bidimensional de bytes de 16x10 llamado **matrixBoard**.

- El arreglo 2D va acorde al número de columnas y número de filas de nuestro tablero (16 filas x 10 columnas).
- El arreglo 2D está a una escala de 1:40 respecto al tablero que es de tamaño 400x640 pixeles.
- Para agregar los tetrominos a esta matrix se usa la función **addTetromino()**, este toma los valores con los que dibujamos cada cuadro/bloque del tetromino y los escala dividiendolos por 40.
