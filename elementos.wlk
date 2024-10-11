import configuracion.*
import wollok.game.*

//Visuales en general//
class Visual { 
    var property position = game.origin()
    var property image  
}

// las "const" se tratan como un objeto (representativo de los escenarios) que seran agregados o removidos conforme se cambie de menu  
const menuSeleccion = new Visual (image=  "menuSeleccion.png")
const escenarioCombate1 = new Visual(image = "fondoVilla.png")
const escenarioCombate2 = new Visual(image = "")
const escenarioCombate3 = new Visual(image = "")



class Selector inherits Visual{
    var property jugador 
    //agregar metodos de movimiento para poder seleccionar personajes 

    method subir() {
    position = position.up(13)
    }

    method bajar() {
    position = position.down(13)
    }

    method irDerecha() {
    position = position.right(26)
    }

    method irIzquierda() {
    position = position.left(26)
    } 

    method seleccionarPersonaje() {
    
    listaDePersonajes.find({unPersonaje => self.position() == unPersonaje.position()})    
    }

}

const selector1 = new Selector(position = game.at(6,1) ,image = "selectorAzul.png", jugador = 1)
const selector2 = new Selector(position = game.at(58, 1), image = "selectorVerde.png", jugador = 2)



//Barras en el menu de combate//
class BarraGeneral{
}

class BarraVida inherits BarraGeneral{}

class BarraEnergia inherits BarraGeneral{}

class BarraEscudo inherits BarraGeneral{}

class BarraMagia inherits BarraGeneral{}

class BarraMunicion inherits BarraGeneral{}