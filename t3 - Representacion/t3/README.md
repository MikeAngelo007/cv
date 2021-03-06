# Taller de representación

## Propósitos

1. Estudiar la relación entre las [aplicaciones de mallas poligonales](https://github.com/VisualComputing/representation), su modo de [representación](https://en.wikipedia.org/wiki/Polygon_mesh) (i.e., estructuras de datos empleadas para representar la malla en RAM) y su modo de [renderizado](https://processing.org/tutorials/pshape/) (i.e., modo de transferencia de la geometría a la GPU).
2. Estudiar algunos tipos de [curvas y superficies paramétricas](https://github.com/VisualComputing/Curves) y sus propiedades.

## Tareas

Empleando el [FlockOfBoids](https://github.com/VisualComputing/frames/tree/master/examples/demos/FlockOfBoids):

1. Represente la malla del [boid](https://github.com/VisualComputing/frames/blob/master/examples/demos/FlockOfBoids/Boid.pde) al menos de dos formas distintas.
2. Renderice el _flock_ en modo inmediato y retenido, implementando la función ```render()``` del [boid](https://github.com/VisualComputing/frames/blob/master/examples/demos/FlockOfBoids/Boid.pde).
3. Implemente las curvas cúbicas de Hermite y Bezier (cúbica y de grado 7), empleando la posición del `frame` del _boid_ como punto de control.

## Opcionales

1. Represente los _boids_ mediante superficies de spline.
2. Implemente las curvas cúbicas naturales.

## Integrantes

Uno, o máximo dos si van a realizar al menos un opcional.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|  Miguel Ángel Tovar          |         MikeAngelo007    |
|  Yeliana Torres          |         yelis3    |

## Entrega

* Subir el código al repositorio de la materia antes del 14/10/18 a las 24h.
* Presentar el trabajo en la clase del 17/10/18 o 18/10/18.

## Explicacion
Al oprimir la letra 'm', el programa cambiara de un modo de representacion a otro. Inicia en modo retenido y cambia a modo inmediato.
Al oprimir la letra 'c', cambia el tipo de representacion del boid, cambiando entre Vertex to Vertex, Face to Vertex, Winged-Edge y Spline superfice.

Para cambiar el modo de representacion en modo retenido, cambiar el valor de typeR (1: Face to Vertex , 2: Vertex to Vertex, 3: Winged-Edge, 4: Spline Superfice) de acuerdo a la representacion que se desea observar. Para modo inmediato, funciona la letra 'c'. Se puede presionar la letra 'u' en caso de no desear activar las superficies de Spline.