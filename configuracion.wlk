//Aca se van a concentrar todas las imagenes que contenga el juego 
import personaje.*
import elementos.*


object sprites{
    const property fondoEscenario1 = " fondovilla.jpg"
    const property fondoEscenario2 = " .png"
    const property finDelJuego     = " .png"

}
//Aca se van a concentrar todos los audios que contenga el juego 
object sounds {
  
}
/*Mediante este objeto se manejara todas las configuraciones del juego. Interaccionara con los jugadores, botones 
  y todo lo que produzca cambios pero el sera el unico responsable de llevar a cabo la accion en si.
*/
object gameManager {

  method cambioMenuIncio() {
    game.boardGround(sprites.fondoEscenario1())
    // y todos los visuales correspondientes al escenario de combate


    //Es para mostrar las estadisticas de los personajes que el jugador elegira//
    game.showAttributes(new Personaje() ) 
    game.showAttributes(new Personaje() )  


    //En este menu se podra elegir cerrar el juego o no 
    self.selectorPersonajes()
    self.cerrarJuego()
    
  }

  method cambioMenuCombate() {
    game.boardGround(sprites.fondoEscenario2())   
    // y todos los visuales correspondientes al escenario de combate
  }

//Menu para poder seleccionar los personajes del juego
  method selectorPersonajes() {
    //delimitar las celdas que ocupa y las imagnes que usara 

  }

  method configuracionIncialTablero() {
	game.title("UTN combat")
	game.height(100)
	game.width(210)
    //ver tamanio de la celda
  }

//CONDICIONES DE TODO EL JUEGO EN GENERAL//

  method condicionDeIncioHaciaCombate() = true //definir con la condicion de botones 

  method condidicionDeCombateHaciaIncio()= true //definir con la condicion de botones

  method puedeSeleccionarJugador2() = true //definir considerando si el jugador presiono el boton o no 

  method puedeFinalizarseElJuego() = true //definir considerando si el jugador presiono el boton o no 

  method noHayMasTiempoEntreAtaques() = true // esto sucede si el timer == 0  


//ACCION DE COMENZAR O CERRAR EL JUEGO//

  method cerrarJuego(){
    if(self.puedeFinalizarseElJuego())
    game.stop()
  }

  method comenzarJuego() {
    game.start()
  }
}


