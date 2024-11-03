import configuracion.*
import elementos.*
import personaje.*



class Jugador{
    var property personaje = null

    method atacaA(jugador) {
        //hay que relacionarlo con los ataques de los personajes que lo jugadores tienen 
      
    }

}

const jugador1 = new Jugador()
const jugador2 = new Jugador()



object combate {
    var property listaPersonajesOrdenada = null
    var property ganador = null 


    method ordenarListaSegunVelocidadDeAtaque() {
       // listaPersonajesOrdenada = listaDePersonajes.sortedBy({personaje1, personaje2 => personaje1.velocidad() > personaje2.velocidad()}) 
    }


    //keyBoard.presionaTecla1 y presionaTecla2 pelea(hablidadP1,habilidadP2)
    method pelea() {
        if(listaPersonajesOrdenada.all({jugador => jugador.vida() > 0})){
            listaPersonajesOrdenada.fold(null, {jugador => jugador.atacarAlResto()})
            self.ordenarListaSegunVelocidadDeAtaque()         
            //self.pelea()
        }
        else
        self.terminarBatalla()
    }

    method terminarBatalla() {
        ganador = 
        if(listaPersonajesOrdenada.all({jugador => jugador.vida() <= 0})) listaPersonajesOrdenada.first()

        else listaPersonajesOrdenada.filter({personaje =>  personaje.vida() > 0}).max({personaje => personaje.vida()})
        }
}



    
