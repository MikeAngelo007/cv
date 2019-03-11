# Taller de interacción y Shaders

## Propósito

Estudiar las tres tareas universales de interacción en entornos virtuales.

## Tareas

Escoja una de las siguientes tres:

1. Emplee un [dispositivo de interfaz humana](https://en.wikipedia.org/wiki/Human_interface_device) no convencional para controlar una escena. Refiérase al ejemplo [SpaceNavigator](https://github.com/VisualComputing/frames/tree/master/examples/basics/SpaceNavigator). Se puede emplear la escena del [punto 2 del taller de transformaciones](https://github.com/VisualComputing/Transformations_ws)
2. Implemente una aplicación de _cámara en tercera persona_. Refiérase al ejemplo [FlockOfBoids](https://github.com/VisualComputing/frames/tree/master/examples/demos/FlockOfBoids).
3. Implemente una aplicación de _control de la aplicación_ (e.g., ["marking menus"](https://www.youtube.com/watch?v=twR_yxuHw24) o [vistas auxiliares](https://www.youtube.com/watch?v=Kr6-_NT_olo&feature=youtu.be&t=214)).

En cualquier caso se puede emplear la librería [frames](https://github.com/VisualComputing/frames) y/o cualquier otra.

Ademas,escoja una de las siguientes dos:

1. Hacer un _benchmark_ entre la implementación por software y la de shaders de varias máscaras de convolución aplicadas a imágenes y video.
2. Estudiar e implementar el [shadow mapping](http://www.opengl-tutorial.org/intermediate-tutorials/tutorial-16-shadow-mapping/). Se puede emplear la escena del [punto 2 del taller de transformaciones](https://github.com/VisualComputing/Transformations_ws), así como la librería [frames](https://github.com/VisualComputing/frames). Ver el ejemplo [ShadowMap](https://github.com/VisualComputing/frames/tree/master/examples/demos/ShadowMap).

## Integrantes

Máximo tres.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|     Yeliana Torres       |      yelis3       |
| Jose Daniel Cifuentes | jdcifuentes |
| Miguel Ángel Tovar Onofre | mikeangelo007 |

## Informe

Laberinto 3D

Generacion de laberinto:

Se utiliza un arreglo de celdas, las cuales se generan automaticamente de acuerdo al tamaño determinado por el usuario. Para generar el camino en medio del laberinto, se recorre cada una de las celdas del mismo, donde analiza las celdas vecinas que aun no han sido visitadas y elige una aleatoriamente, elimina los muros entre ambas celdas y continua con el camino. Si se encuentra en una celda donde todos sus vecinos han sido visitados, busca la ultima celda donde se hayan encontrado vecinos sin visitar y continua el camino a partir de ella.

Navegacion e interaccion con el espacio:
Por medio de la libreria GameControlPlus, se realizo la configuración y adaptación de un control de consola Xbox 360, para navegar por el espacio del laberinto usando los joysticks del control.

## Entrega

Fecha límite Domingo 10/3/19 a las 24h.