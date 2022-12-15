**APIs needed**

![](RackMultipart20221215-1-vzg4s3_html_1505e633d001c2d6.png)

_High-level Client/Server system architecture_

Para la api, opte por usar una que ya estaba y que básicamente hace lo que se pide, para mayor información

[https://dev.kiwilimon.com/documentacion-v6/search](https://dev.kiwilimon.com/documentacion-v6/search)

**High-Level Solution**

Para la arquitectura, usaré MVVM - Clean - Coordinator, ya que hace sentido por el tamaño de la aplicación.

Entre las ventajas que tiene MVVM - Clean:

- Escalable debido a que el viewmodel depende de UseCase que fácilmente pueden incrementar.
- Testeable: Al ser todo modularizado, todos los componentes se pueden testear de manera única (Unit Test) y de manera integrada (Integration Test)
- Fácil de mantener, ya que la lógica de negocio está separada de la vista y el network layer.
- Una de las reglas que se deben de seguir es hacer que la regla de inyección de dependencias se cumpla como en el diagrama. En otras palabras, la capa de Dominio no debe tener ningún import de UIKi
- Uso de principios SOLID

![](RackMultipart20221215-1-vzg4s3_html_febea557f5b8597a.png)

**Presentation Layer**

La capa de presentación, contiene toda la UI, que son coordinados por el Coordinator y ViewModel. El ViewModel puede ejecutar uno o múltiples UseCases's. La capa de Presentación depende enteramente de la capa de Dominio

**Domain Layer**

En esta capa la parte más importante es que no debe contener dependencias con otras capas. Esta contiene todas las Entidades, UsesCases y Repositorios.

**Data Layer**

La capa de Datos implementa los repositorios, en este caso, serían los Servicios.

Los Servicios son responsables de coordinar los datos entre las diferentes fuentes de datos: Backend o Bases de datos

La capa de Datos depende enteramente de la capa de Dominio

**Modules**

![](RackMultipart20221215-1-vzg4s3_html_262e8d6f49304827.png)

La aplicación se divide en 3 módulos:

Categorías:

Contiene categorías de recetas de cocina, como por ejemplo: más saludables, por ingredientes, por temporada, etc.

Lista de Recetas:

Una vez que se consulta una categoría, se muestra la lista de recetas de esa categoría seleccionada

Receta:

Una vez que se da click en la receta, se abrirá el detalle de esa receta

**Patrones de diseño**

Entre los diversos patrones de diseño, los más comunes que hay en la app son:

- Coordinator: Se usa para la navegación entre las diversas vistas
- Delegate: Para UIKIt
- Builder: Para la construcción de los modulos
- Observer: Con Combine, para escuchar los updates de la vista y reaccionar a estos

**Components and Layers**

![](RackMultipart20221215-1-vzg4s3_html_2f16ab9493fa4c46.png)

**Libraries**

Para el uso de librerías se usan las siguientes:

- Combine
- Foundation
- UIKit
- SDWebImage
