import habilidades.*
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

  const property visualesInicio = 
    [menuSeleccion ,selector1, selector2,celdaBajo1,celdaBajo2,celdaBajo3, 
    celdaArribaIzq,celdaBajoIzq ,celdaMedioIzq,celdaArriba1,celdaArriba2,celdaArriba3, 
    celdaArribaDer, celdaMedioDer , celdaBajoDer ,celdaLogo, ivar , ragnar
    ] //mas todos los personajes aun no creados 
  const property visualesCombate = [jugador1.personaje(),jugador2.personaje()]


  method menuIncio() {

    visualesInicio.forEach({visual => game.addVisual(visual)})


    game.schedule(500,{sonidoFondo.play()})
    sonidoFondo.shouldLoop(true)

  }

  method menuCombate(personaje1,personaje2) {

    visualesInicio.forEach({visual => game.removeVisual(visual)})

    game.addVisual(escenariosCombate.anyOne())

    personaje1.position(game.at(14,10))
    game.addVisual(personaje1)
    
    personaje2.position(game.at(60,10))
    game.addVisual(personaje2)
  //combate.forEach({visual => game.addVisual(visual)}) NO ANDA Y NO SE POR QUE     

    self.configuracionHabilidades(personaje1.habilidades(), personaje2.habilidades())

    game.schedule(500, {sonidoComienzoPelea.play()})
    game.schedule(4000, {sonidoFondoCombate.play()})
    sonidoFondoCombate.shouldLoop(true)

    combate.listaPersonajesOrdenada([personaje1, personaje2])
    combate.ordenarListaSegunVelocidadDeAtaque()

    game.onTick(5000, "Pelear", {combate.pelea()})
  
  
  }

method configuracionHabilidades(personaje1,personaje2) {
  
  personaje1.inicializarHabilidades(game.at(3,5) ,game.at(3,4), game.at(3,3) , game.at(3,2))  
  personaje2.inicializarHabilidades(game.at(26,5) ,game.at(26,4), game.at(26,3) , game.at(26,2) )

  //chequear no aparece el visual
  personaje1.habilidades().forEach({texto => game.addVisual(texto)})
  personaje2.habilidades().forEach({texto => game.addVisual(texto)})

}
//Chequear porque no aparec

method seleccionPersonaje() {  
    self.cambioDeMenu()
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

  method cambioDeMenu() {
  sonidoFondo.stop()
  self.menuCombate(jugador1.personaje(),jugador2.personaje())
  }

/*
    keyboard.l().onPressDo({     
                              sonidoFondoCombate.stop()
                              sonidoComienzoPelea.stop()
                              self.menuIncio()})
*/

method configuracionDeDesplazamiento() {

//desplazamiento J1
  keyboard.left().onPressDo({selector1.irIzquierda()})
  keyboard.right().onPressDo({selector1.irDerecha()})
  keyboard.up().onPressDo({selector1.subir()})
  keyboard.down().onPressDo({selector1.bajar()})

  //COMBATE J1
  keyboard.q().onPressDo({jugador1.personaje().listoParaPelear(jugador1.habilidades().get(0))}) 
  keyboard.e().onPressDo({jugador1.personaje().listoParaPelear(jugador1.habilidades().get(1))})
  keyboard.r().onPressDo({jugador1.personaje().listoParaPelear(jugador1.habilidades().get(2))})
  keyboard.t().onPressDo({jugador1.personaje().listoParaPelear(jugador1.habilidades().get(3))})


//desplazamiento J2
  keyboard.w().onPressDo({selector2.subir()})
  keyboard.s().onPressDo({selector2.bajar()})
  keyboard.a().onPressDo({selector2.irIzquierda()})
  keyboard.d().onPressDo({selector2.irDerecha()})

  //COMBATE J2
  keyboard.z().onPressDo({jugador2.personaje().listoParaPelear(jugador1.habilidades().get(0))})
  keyboard.x().onPressDo({jugador2.personaje().listoParaPelear(jugador1.habilidades().get(1))})
  keyboard.c().onPressDo({jugador2.personaje().listoParaPelear(jugador1.habilidades().get(2))})
  keyboard.v().onPressDo({jugador2.personaje().listoParaPelear(jugador1.habilidades().get(3))})

//Seleccion personaje 
  keyboard.enter().onPressDo({self.seleccionPersonaje()})



  game.whenCollideDo(selector1, {elemento => selector1.colisiona(elemento)})
  game.whenCollideDo(selector2, {elemento => selector2.colisiona(elemento)})

}

//ACCION DE COMENZAR O CERRAR EL JUEGO//
  method cerrarJuego(){
  game.stop()
  }

  method comenzarJuego() {
    game.start()
  }
}