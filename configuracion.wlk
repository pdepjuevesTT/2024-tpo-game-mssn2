import personaje.*
import elementos.*
import wollok.game.*
import jugador.*

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
  const escenariosCombate = [escenarioCombate1] //falta agregar los otros, logica implementada

  method menuIncio() {

    game.addVisual(menuSeleccion)
    game.addVisual(selector1)
    game.addVisual(selector2)

    game.schedule(500,{sonidoFondo.play()})
    sonidoFondo.shouldLoop(true)

  //game.addVisualCharacter(pixel)

   // self.cargarLimites()

  }

  method menuCombate() {

    game.removeVisual(menuSeleccion)

    game.addVisual(escenariosCombate.anyOne())

    self.seleccionPersonaje()
    
    //game.schedule(500, {sonidoComienzoPelea.play()})
    //game.schedule(4000, {sonidoFondoCombate.play()})
    //sonidoFondoCombate.shouldLoop(true)

    self.sistemasDeTurnos()
  
  }

/*
  method cargarLimites() {
    const ancho = game.width() - 5
    const largo = game.width() - 5
    const limites =[]

    (0 .. ancho).forEach(
			{ n => limites.add(new Position(x = n, y = 0)) }
		) // bordeAbajo
		
		(0 .. ancho).forEach(
			{ n => limites.add(new Position(x = n, y = largo)) }
		) // bordeArriba 
		
		(0 .. largo).forEach(
			{ n => limites.add(new Position(x = 0, y = n)) }
		) // bordeIzq 
		
		(0 .. largo).forEach(
			{ n => limites.add(new Position(x = ancho, y = n)) }
		) // bordeDer
    
    limites.addAll(
      [

      ]
    )


    limites.forEach({posicion => game.addVisual(new Limite(position = posicion))})

  }
*/


//hardcodeado
method seleccionPersonaje() {
  
  //JUGADOR 1
  game.addVisual(stan)
  //game.addVisual(golpeBasico1)
  //game.showAttributes(golpeBasico1)

 // game.addVisual(golpeBasico2)
  //game.showAttributes(golpeBasico2)


 // game.addVisual(noOfensiva)
  //game.showAttributes(noOfensivaa)


  game.addVisual(ulti)
  game.showAttributes(ulti)



  //JUGADOR2
  game.addVisual(carman)

  //game.addVisual(golpeBasicoo1)
  //game.showAttributes(golpeBasicoo1)

  //game.addVisual(golpeBasicoo2)
  //game.showAttributes(golpeBasicoo2)

  //game.addVisual(noOfensivaa)
  //game.showAttributes(noOfensivaa)

  game.addVisual(ultii)
  game.showAttributes(ultii)

}

  method configuracionIncialTablero() {
	game.title("UTN combat")
	game.height(40)
	game.width(88)
  game.cellSize(25)
  game.boardGround("grisFondo.png")
  }


  method configuracionSonido() {
    keyboard.num1().onPressDo({sonidoFondo.pause()})
    keyboard.num0().onPressDo({sonidoFondo.resume()})
    keyboard.num2().onPressDo({sonidoFondo.volume(0.5)})
    keyboard.num3().onPressDo({sonidoFondo.volume(1)})
  }

  method configuracionCambioDeMenu() {
    keyboard.n().onPressDo({
                              sonidoFondo.stop()
                              self.menuCombate()})
    keyboard.l().onPressDo({     
                              sonidoFondoCombate.stop()
                              sonidoComienzoPelea.stop()
                              self.menuIncio()})
  }

method configuracionDeDesplazamiento() {

  keyboard.left().onPressDo({selector1.irIzquierda()})
  keyboard.right().onPressDo({selector1.irDerecha()})
  keyboard.up().onPressDo({selector1.subir()})
  keyboard.down().onPressDo({selector1.bajar()})
  keyboard.enter().onPressDo({selector1.seleccionarPersonaje(jugador1)})


  keyboard.w().onPressDo({selector2.subir()})
  keyboard.s().onPressDo({selector2.bajar()})
  keyboard.a().onPressDo({selector2.irIzquierda()})
  keyboard.d().onPressDo({selector2.irDerecha()})
  keyboard.space().onPressDo({selector2.seleccionarPersonaje(jugador2)})

  //FALTAR DELIMITAR LOS BORDES//  
}

//ACCION DE COMENZAR O CERRAR EL JUEGO//
  method cerrarJuego(){
  game.stop()
  }

  method comenzarJuego() {
    game.start()
  }
}


object sistemaDeTurnos {
  var property jugador1 = null
  var property jugador2 = null 
  

  method verificarReglaInicioPelea(unPersonaje , otroPersonaje) = 
    if()
}