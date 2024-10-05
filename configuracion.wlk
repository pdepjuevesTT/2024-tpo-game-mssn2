//Aca se van a concentrar todas las imagenes que contenga el juego 
import jugador.*

object sprites{
    const property fondoEscenario1 = " fondovilla.jpg"
    const property fondoEscenario2 = " .png"
    const property finDelJuego     = " .png"

}
//Aca se van a concentrar todos los audios que contenga el juego 
object sounds {
  
}
//Mediante este objeto se manejara todas las configuraciones del juego 
object gameManager {

  method cambioMenuIncio() {
    game.boardGround(sprites.fondoEscenario1())
    self.selectorPersonajes()
    self.cerrarJuego()
    //Es para mostrar las estadisticas de los personajes que el jugador elegira//
    game.showAttributes(new Personaje() ) 
    game.showAttributes(new Personaje() )  
    

    
  }

  method cambioMenuCombate() {
    game.boardGround(sprites.fondoEscenario2())   
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

  method condicionDeIncioHaciaCombate() = true

  method condidicionDeCombateHaciaIncio()= true

  method cerrarJuego(){
    game.stop()
  }
}
