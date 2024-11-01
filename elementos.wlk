import configuracion.*
import wollok.game.*
import personaje.*


//Visuales en general//
class Visual { 
    var property position = game.origin()
    var property image  
}

//NO TERMINADO
class Limite inherits Visual{

    override method image() = "pixelNegro.png"

    method moverse(direccion) {
        throw new DomainException (message = "No se puede atravesar este limite")
    }
}

const pixel= new Limite(image = "pixelNegro.png")

// las "const" se tratan como un objeto (representativo de los escenarios) que seran agregados o removidos conforme se cambie de menu  
const menuSeleccion = new Visual (image=  "menuSeleccion.png")
const escenarioCombate1 = new Visual(image = "fondoVilla.png")
const escenarioCombate2 = new Visual(image = "")
const escenarioCombate3 = new Visual(image = "")




class Selector inherits Visual{
    var property jugador 
    //agregar metodos de movimiento para poder seleccionar personajes 
    const grillas = [grilla1, grilla2]

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
    
    method encontrarGrillaActual() {
        return grillas.find({ grilla => self.position() == grilla.position() }) // Encuentra la grilla actual
    }

    method seleccionarPersonaje() {
        const grilla = self.encontrarGrillaActual()
        if (grilla != null && grilla.tienePersonaje()) {
            jugador.personaje(grilla.personajeActual)
        }

    }
    //method encontrarPersonajeEnCasillaQueEstoy() = listaDePersonajes.find({personaje => self.position() ==  personaje.position()})    

//NO SE SI ES RESPONSABILIDAD DEL SELECTOR O DEL EL JUGADOR//
/*
    method seleccionarPersonaje(unJugador) {
    unJugador.personaje(self.encontrarPersonajeEnCasillaQueEstoy())
    }

*/

}

// codigo de los bepis (Nico y Santi)

class Grilla inherits Visual {
    //var property position
    var property personajeActual 
    //El personaje que puede estar en esta grilla
    //Constructor para inicializar la posición de la grilla y si contiene un personaje
    /*
    constructor(position, personaje = null) {
        self.position = position
        self.personaje = personaje
    }
    */

    // Método para verificar si la grilla tiene un personaje
    method tienePersonaje() = personajeActual != null
}

const grilla1 = new Grilla(position = game.at(1,1), image = "fotoStan", personajeActual = stan)
const grilla2 = new Grilla(position = game.at(30,30), image = "fotoCarman", personajeActual = carman)

// codigo de los bepis (Nico y Santi)


const selector1 = new Selector(position = game.at(6,1) ,image = "selectorAzul.png", jugador = 1)
const selector2 = new Selector(position = game.at(58, 1), image = "selectorVerde.png", jugador = 2)



const golpeBasico1 = new Visual(position = game.at(12,3) ,  image ="basico1Dimensionado.png" )
const golpeBasico2 = new Visual(position = game.at(12,9) ,  image = "basico2Dimensionado.png")
const noOfensiva   = new Visual(position = game.at(12,15) ,  image ="noOfensivaDimensionado.png" )
const ulti         = new Visual(position = game.at(0,10) ,  image = "ultiDimensionada.png")


const golpeBasicoo1 = new Visual(position = game.at(60,3) ,  image ="basico1Dimensionado.png" )
const golpeBasicoo2 = new Visual(position = game.at(60,9) ,  image = "basico2Dimensionado.png")
const noOfensivaa   = new Visual(position = game.at(60,15) ,  image ="noOfensivaDimensionado.png" )
const ultii         = new Visual(position = game.at(45,10) ,  image = "ultiDimensionada.png")

//Barras en el menu de combate//
class BarraGeneral{
}

class BarraVida inherits BarraGeneral{}

class BarraEnergia inherits BarraGeneral{}

class BarraEscudo inherits BarraGeneral{}

class BarraMagia inherits BarraGeneral{}

class BarraMunicion inherits BarraGeneral{}