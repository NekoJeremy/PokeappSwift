Prueba Cencosud iOS Devs

El desafío consiste en desarrollar un proyecto en SwiftUI para evaluar tu proceso de desarrollo y conocimientos técnicos. Quisiéramos saber los desafíos que tuviste en el desarrollo y como los enfrentaste, vale decir que no esperamos que el proyecto este 100%, pero si parte importante de lo que pedimos como esencial.

1.	Desafío:

Construye un proyecto de búsqueda de pokemones utilizando una api publica, que contenga las siguientes funcionalidades:
-	Mostrar resultados en un listado con paginación (20 ítems por página)
-	Seleccionar un ítem de la búsqueda y mostrar el detalle de un pokemon que contenga lo siguiente:
o	Mostrar un Carrusel de imágenes que se pueda hacer drag y visualizar una a la vez (utilizar campo “sprites” que contiene las imágenes).
o	Nombre del pokemon
o	Descripción del pokemon
o	Debe tener un botón para compartir el pokemon, esto puede ser utilizando la imagen o la url del detalle del pokemon. Y debe permitir compartirlo mediante otra app.
o	Botón para agregar a favoritos (cambiar texto a eliminar de mis favoritos una vez que esté agregado)
-	Almacenar localmente las búsquedas realizadas y ofrecer repetirlas en caso de no tener conexión a internet. Esto significa que utilice cache para el response de la búsqueda y aparte almacene el texto buscado en persistencia.
-	Manejar errores 500 o 400 mostrando un mensaje tipo pop up en la parte superior de la vista.
-	Crear una sección de mis pokemones favoritos.
-	Usar animaciones y transiciones nativas de SwiftUI en los siguientes pasos:
o	Carga de imágenes
o	Carga de listado (utilizar un loading si es necesario)

URL: Listado de pokemones (GET)
https://pokeapi.co/api/v2/pokemon?limit=10&offset=0

Donde limit es la cantidad a mostrar y offset el índice inicial

Detalle de un pokemon (GET):
https://pokeapi.co/api/v2/pokemon/charmander

2.	Sobre el Desarrollo: 

Obligatorios:

-	Utilizar SwiftUI para la creación de vistas.
-	Subir el proyecto a un repositorio, queremos saber como haces tus commits.
-	Selecciona bibliotecas que te ayuden a resolver el problema y justifica su uso, se debe utilizar Swift Package Manager para las dependencias.
-	Utilizar persistencia de datos (CoreData, UserDefaults, etc…).
-	Utilizar principios SOLID.

Opcionales

-	Utilizar Combine
-	Crear Test Unitarios sobre llamado de servicios (Utilizar Mock)
-	Que se pueda visualizar multiplataforma (iPhone, iPad, iPod)
