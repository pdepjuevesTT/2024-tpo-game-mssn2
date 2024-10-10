import personaje.*
import elementos.*
import wollok.game.*

//Aca se van a concentrar todos los audios que contenga el juego 
object sounds {
  const property backGround = "backgroundSound.mp3" 
  const property round1     = "round1.mp3" 
  const property fondoCombate = "fondoCombate.mp3" 
  
}
/*Mediante este objeto se manejara todas las configuraciones del juego. Interaccionara con los jugadores, botones 
  y todo lo que produzca cambios pero el sera el unico responsable de llevar a cabo la accion en si.
*/
object gameManager {
  const property sonidoFondo = game.sound(sounds.backGround())
  const property sonidoComienzoPelea = game.sound(sounds.round1())
  const property sonidoFondoCombate = game.sound(sounds.fondoCombate()) 

  method menuIncio() {

    game.boardGround(pantallaIncio)

    game.schedule(2000,{sonidoFondo.play()})
    sonidoFondo.shouldLoop(true)

    game.addVisual(seleccionador)
 
  }

  method menuCombate() {
    game.removeVisual(seleccionador)
    sonidoFondo.stop()
    
    game.boardGround(escenarioCombate1)    
    game.schedule(500, {sonidoComienzoPelea.play()})
    game.schedule(4000, {sonidoFondoCombate.play()})
    sonidoFondoCombate.shouldLoop(true)

  
  
  }

//recibe todas las instrucciones por parte de los JUGADORES (diferente a los personajes)
  //method recibirInstrucciones() {
  //  keyboard.enter().onPressDo{condicionParaFinalizarJuego = true}
  //}

  method configuracionIncialTablero() {
	game.title("UTN combat")
	game.height(10)
	game.width(22)
  game.cellSize(100)
  }


  method configuracionSonido() {
    keyboard.num1().onPressDo({sonidoFondo.pause()})
    keyboard.num0().onPressDo({sonidoFondo.resume()})
    keyboard.num2().onPressDo({sonidoFondo.volume(0.5)})
    keyboard.num3().onPressDo({sonidoFondo.volume(1)})
  }

  method configuracionCambioDeMenu() {
    keyboard.right().onPressDo({self.menuCombate()})
    keyboard.left().onPressDo({self.menuIncio()})
  }


//ACCION DE COMENZAR O CERRAR EL JUEGO//
  method cerrarJuego(){
  game.stop()
  }

  method comenzarJuego() {
    game.start()
  }
}



