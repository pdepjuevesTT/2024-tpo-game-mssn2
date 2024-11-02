import configuracion.*
import wollok.game.*
import personaje.*


//Visuales en general//
class Visual { 
    var property position = game.origin()
    var property image  
}

class Limite inherits Visual{

    //override method image() = "pixelNegro.png"

    method colision() {
        throw new DomainException(message = "No se puede atravesar este limite")
    }
}   

const celdaArriba1 =new Limite(image = "celdaBalanca.png" , position = game.at(6,40))
const celdaArriba2 =new Limite(image = "celdaBalanca.png" , position = game.at(32,40))
const celdaArriba3 =new Limite(image = "celdaBalanca.png" , position = game.at(58,40))

const celdaArribaIzq =new Limite(image = "celdaBalanca.png" ,position = game.at(-20,27))
const celdaBajoIzq = new Limite(image = "celdaBalanca.png" ,position = game.at(-20,1))
const celdaMedioIzq= new Limite(image = "celdaBlanca.png" ,position =game.at(-20,14))

const celdaBajo1 = new Limite(image = "celdaBalanca.png" , position = game.at(6,-12)) 
const celdaBajo2 = new Limite(image = "celda",position = game.at(32,-12))
const celdaBajo3 = new Limite(image = "celda",position = game.at(58,-12))

const celdaArribaDer =new Limite(image = "pixel.jpg" ,position = game.at(84,27))
const celdaMedioDer = new Limite(image = "pixel.jpg" ,position = game.at(84,14))
const celdaBajoDer  = new Limite(image = "pixel.jpg" ,position = game.at(84,1))

/*
en (6,1) -> personaje1
en (6,14) -> personaje2
en (6,27) -> personaje3
en (32,27) -> personaje4
en(58,27) -> personaje5
en(58,14) -> personaje6
en(58,1)->personaje7
en(32, 1) -> peronsaje8
*/



// las "const" se tratan como un objeto (representativo de los escenarios) que seran agregados o removidos conforme se cambie de menu  
const menuSeleccion = new Visual (image=  "menuSeleccion.png")
const escenarioCombate1 = new Visual(image = "fondoVilla.png")
const escenarioCombate2 = new Visual(image = "")
const escenarioCombate3 = new Visual(image = "")


class Selector inherits Visual{
    var property jugador 
    var direccion = arriba
    //agregar metodos de movimiento para poder seleccionar personajes 
    //const grillas = [grilla1, grilla2]

    
    
    method subir() {
    direccion = arriba
	self.avanzar()
    }

    method bajar() {
    direccion = abajo
	self.avanzar()
    }

    method irDerecha() {
    direccion = derecha
	self.avanzar()
    }

    method irIzquierda() {
    direccion = izquierda
	self.avanzar()
    } 
    
    method avanzar() {
		position = direccion.siguiente(position)
	}

    method retrocede() {
		position = direccion.opuesto().siguiente(position)
    }

    method colision(){} //solo por el hecho de que un selector puede colisionar con otro

    method colisiona(elemento) {
        try{
        elemento.colision()}
        catch e{
            self.retrocede()
            throw e        
        }
    }
    
    
    /*
    method encontrarGrillaActual() {
        return grillas.find({ grilla => self.position() == grilla.position() }) // Encuentra la grilla actual
    }

    method seleccionarPersonaje() {
        const grilla = self.encontrarGrillaActual()
        if (grilla != null && grilla.tienePersonaje()) {
            jugador.personaje(grilla.personajeActual)
        }
    }
    // codigo de los bepis (Nico y Santi)
    */

}



object izquierda{ 
	method siguiente(position) = position.left(26) 
	method opuesto() = derecha
}

object derecha{ 
	method siguiente(position) = position.right(26) 
	method opuesto() = izquierda
}

object abajo{ 
	method siguiente(position) = position.down(13) 
	method opuesto() = arriba
}

object arriba{ 
	method siguiente(position) = position.up(13) 
	method opuesto() = abajo
}


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