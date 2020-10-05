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
5. [¿Cómo se representa cada uno de los tetrominos activos?](#4-instalación-del-módulo)
6. [¿Cómo se almacenan y leen los tetrominos que ya han caído?](#5-algunas-funcionalidades)

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

## Codificación del tetromino activo

El tetromino activo se representa mediante un entero equivalente a su representación en bits matricial de tamaño 4x4, donde 0 es un bloque vacío y 1 es un bloque lleno.

**Ejemplo:**
¿Cómo se representa el tetromino j con la rotación 3?




## Desplazamiento del tetromino

<p align="left"><img src="https://alejandrohiguera.codes/POO2020/tetromino.png" width="50%"></p>
