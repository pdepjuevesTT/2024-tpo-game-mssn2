//Aca se van a concentrar todas las imagenes que contenga el juego 
import personaje.*
import elementos.*


object sprites{
    const property fondoEscenario1 = "fondovilla.jpg"
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
  var property condicionParaFinalizarJuego = false
  var property condicionCambioDeEscenario = false
  var property puedeSeleccionarElOtroJugador = false
  var property seAcaboElTurno = false

  method cambioMenuIncio() {
    game.boardGround(sprites.fondoEscenario1())
    // y todos los visuales correspondientes al escenario de combate
    self.recibirInstrucciones()

    //Es para mostrar las estadisticas de los personajes que el jugador elegira//
    //game.showAttributes(new Personaje() ) 
    //game.showAttributes(new Personaje() )  

    //En este menu se podra elegir cerrar el juego o no 
    
  if(self.condicionCambioDeEscenario()){self.cerrarJuego()}
    //selectorDePersonaje.elegirPersonaje()
 
  }

  method cambioMenuCombate() {
    game.boardGround(sprites.fondoEscenario2()) 
    self.recibirInstrucciones()  
    // y todos los visuales correspondientes al escenario de combate
  }

//recibe todas las instrucciones por parte de los JUGADORES (diferente a los personajes)
  method recibirInstrucciones() {

    keyboard.enter().onPressDo{self.text()}
    
  }


method text() ="Hola"

  method configuracionIncialTablero() {
	game.title("UTN combat")
	game.height(100)
	game.width(210)
    //ver tamanio de la celda
  }


//ACCION DE COMENZAR O CERRAR EL JUEGO//

  method cerrarJuego(){
  game.stop()
  }

  method comenzarJuego() {
    game.start()
  }
}


