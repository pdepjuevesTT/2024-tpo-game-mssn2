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
    celdaArribaDer, celdaMedioDer , celdaBajoDer ,celdaLogo, ivar , ragnar,dibu,legolas,ron,harry,ezio,desmond
    ]
  const property personajesCombate = []


  method menuIncio() {

    visualesInicio.forEach({visual => game.addVisual(visual)})


    game.schedule(500,{sonidoFondo.play()})
    sonidoFondo.shouldLoop(true)

  }

  method menuCombate() {

    visualesInicio.forEach({visual => game.removeVisual(visual)})

    game.addVisual(escenariosCombate.anyOne())

    personajesCombate.first().position(game.at(14,6))
    personajesCombate.first().inicializarPersonaje("Derecha")
    personajesCombate.first().inicializarBarras(game.at(0,35),game.at(16,35),1)
    //personajesCombate.first().barras().forEach({barra => game.addVisual(barra)})
    personajesCombate.last().inicializarBarras(game.at(49,35),game.at(65,35),1)
    personajesCombate.last().position(game.at(60,6))
    personajesCombate.last().inicializarPersonaje("Izquierda")

    personajesCombate.forEach({personaje => personaje.cambiarImagen(personaje.imagenBatalla()) 
                                          game.addVisual(personaje)})  

    self.configuracionHabilidades(personajesCombate)


    game.schedule(500, {sonidoComienzoPelea.play()})
    game.schedule(4000, {sonidoFondoCombate.play()})
    sonidoFondoCombate.shouldLoop(true)

    combate.personajes(personajesCombate)

    game.onTick(1000, "Pelear", {combate.pelea()})
    game.onTick(1000,"barra",{personajesCombate.forEach({personaje => personaje.actualizarBarras()})})
  
  }

method configuracionHabilidades(listaPersonajes) {
  // ver cómo generalizar esto
  listaPersonajes.get(0).inicializarHabilidades(game.at(4,5) ,game.at(14,5), game.at(25,5) , game.at(35,5))  
  listaPersonajes.get(1).inicializarHabilidades(game.at(50,5) ,game.at(61,5), game.at(71,5) , game.at(81,5))

  listaPersonajes.forEach({personaje => personaje.habilidades().forEach({texto => game.addVisual(texto)})})
  letrasCombate.forEach({text => game.addVisual(text)})

} 

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
  personajesCombate.addAll([jugador1.personaje(),jugador2.personaje()])
  self.menuCombate()
  }

method configuracionDeDesplazamiento() {

//desplazamiento J1
  keyboard.left().onPressDo({selector1.moverse(izquierda)})
  keyboard.right().onPressDo({selector1.moverse(derecha)})
  keyboard.up().onPressDo({selector1.moverse(arriba)})
  keyboard.down().onPressDo({selector1.moverse(abajo)})

  //COMBATE J1
  //delegar al personaje
  //const habilidades = jugador1.personaje().habilidades()
  keyboard.q().onPressDo({jugador1.personaje().listoParaPelear(jugador1.personaje().habilidades().get(0))}) 
  keyboard.e().onPressDo({jugador1.personaje().listoParaPelear(jugador1.personaje().habilidades().get(1))})
  keyboard.r().onPressDo({jugador1.personaje().listoParaPelear(jugador1.personaje().habilidades().get(2))})
  keyboard.t().onPressDo({jugador1.personaje().listoParaPelear(jugador1.personaje().habilidades().get(3))})


//desplazamiento J2
  keyboard.w().onPressDo({selector2.moverse(arriba)})
  keyboard.s().onPressDo({selector2.moverse(abajo)})
  keyboard.a().onPressDo({selector2.moverse(izquierda)})
  keyboard.d().onPressDo({selector2.moverse(derecha)})

  //COMBATE J2
  keyboard.z().onPressDo({jugador2.personaje().listoParaPelear(jugador2.personaje().habilidades().get(0))})
  keyboard.x().onPressDo({jugador2.personaje().listoParaPelear(jugador2.personaje().habilidades().get(1))})
  keyboard.c().onPressDo({jugador2.personaje().listoParaPelear(jugador2.personaje().habilidades().get(2))})
  keyboard.v().onPressDo({jugador2.personaje().listoParaPelear(jugador2.personaje().habilidades().get(3))})

//Seleccion personaje 
  keyboard.enter().onPressDo({self.seleccionPersonaje()})



  game.whenCollideDo(selector1, {elemento => selector1.colisiona(elemento)})
  game.whenCollideDo(selector2, {elemento => selector2.colisiona(elemento)})

}
  method cerrarJuego(){
  game.stop()
  }

  method comenzarJuego() {
    game.start()
  }
}

object grilla{
  const property posiciones = [game.at(6,1),game.at(6,14),game.at(6,27),game.at(58,1),game.at(32,27),game.at(32,27),game.at(58,14),game.at(32,1)] 
  const property movimientoEnX = 26
  const property movimientoEnY = 13
  method inicializarGrilla() {
    // personajes.forEach({personaje => personaje.asignarPosicion()})
  }
}

class Posicion{
  const property personaje 
  const property posicion
}
