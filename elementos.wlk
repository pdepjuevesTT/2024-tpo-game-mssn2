import configuracion.*
import wollok.game.*

//En este caso iran como sera el comportamiento de la barra de vida, energia y una barra adicional depediendo del tipo de personaje que sea 
class BarraGeneral{
}

class BarraVida inherits BarraGeneral{}

class BarraEnergia inherits BarraGeneral{}

class BarraEscudo inherits BarraGeneral{}

class BarraMagia inherits BarraGeneral{}

class BarraMunicion inherits BarraGeneral{}


class Boton{
    var property posicion

    method image() 

}


class Visual { 
    var property position = game.origin()
    var property image  
}

// las "const" se tratan como un objeto (representativo de los escenarios) que seran agregados o removidos conforme se cambie de menu  
const pantallaIncio = new Visual(image = "logoUTNKombat.png")  
const escenarioCombate1 = new Visual(image = "fondovilla.jpg")
const escenarioCombate2 = new Visual(image = "")
const escenarioCombate3 = new Visual(image = "")






object seleccionador {
    var property position = game.at(6,0)

    method image() = "selector.png"
}


