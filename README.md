# Training
Training app 

## Arquitectura
**VIPER**

## 1. Capas de la aplicacion
La aplicacion esta planteada para que sea escalable por modulos siendo el de busqueda y detalla el que se desarrollo y utilizando una arquitectura VIPER (Vista, Interactor, Presenter, Entity y Router) ademas de contar con una interface de   coneccion para realiazar todas la peticiones. Adelate se describe las clases por las diferentes capas

- Pantalla Home y de Busqueda
  - Vista: SearchViewController y SearchViewControllerSB
  - Presenter: SearchViewPresenter
  - Interactor: SearchViewInteractor
  - Entity: EntityMostPopular, EntityMostRated y EntityUpcoming
- Pantalla Detalle
  - Vista: DetailViewController y DetailViewControllerSB
  - Presenter: DetailViewPresenter
  - Interactor: DetailViewInteractor
  - Entity: SearchResultModel (que puede ser de cualquier tipo EntityMostPopular, EntityMostRated y EntityUpcoming)
- Aplicacion general
  - Router de la aplicacion: RouterSearchDetail
  - Interface de Conexion: ConnectionManager
  
## 2. Responsabilidades:
  - Vista: son la pantalla y el controlador que se encarga de actualizar con la informacion que le envia el presentador, en el caso de la prueba desarrollada se tienen dos pantallas la de home o busqueda y la de detalle 

  - Presenter: se encarga de manejar toda la logica de la vista como son interacciones inicializacion de la pantalla ademas de logica de negocio y ser el punto conector entre todas las capas de la arquitectura. En el ejemplo se tienen 2 presentadores ya que es uno por pantalla

  - Interactor: Se encarga de manejar la capa de persistencia ademas de realizar todas las peticiones a los servicios. En este caso igual se tienen dos en el caso de la pantalla de busqueda el interactor realiza 4 peticiones, una por cada una de las 3 categorias mas una de configuracion para conocer las especificaciones de las imagenes soportadas, dado que no indague mas si habia una unica forma de obtener las tres categorias en una sola peticion.

En este modulo para poder tener un mejor performance de la app de envian las 4 peticioness mediante un "Dispatch Group" y solo se espera ha que respondan todas para posteriormente avisar al presenter que ya se obtuvo una respuesta

  - Entity: Va ligado directamente al Interactor ya que es el modelado de las respuestas de los servicios o de los elemento que se puedan persistir, en este caso se tienen tres entities una por cada categoria pero se modifico la estructura comun de las entidades para que guardaran el codigo de respuesta de la peticion ya que se ejecutan de manera concurrente. Para el caso de la pantalla de detalle no se tiene un "entity" particular si no que se pasa del interactor de la pantalla de busqueda

  - Router: Se encarga de la creacion de uno o mas modulos y la navegacion dentro de estos mismos. En la aplicacion hay solo un modulo que es el de busqueda y detalle y la unica navegacion es entre dichas pantallas, pero podriamos crear un nuevo modulo por ejemplo de favoritos o settings y ponerlos en tabs ya sea con el mismo router si no es muy extensa o bien un router por modulo y desoues uno de la aplicacion


