import configuracion.*

class Jugador{
    var property personaje = null

    method atacaA(jugador) {
        //hay que relacionarlo con los ataques de los personajes que lo jugadores tienen 
      
    }

}

const jugador1 = new Jugador()
const jugador2 = new Jugador()

object combate {
    var property jugador1 = null
    var property jugador2 = null
    var property jugadorQuePegaPrimero = self.pegaPrimero()
    var property ganador = null 


//Verificar que no este tan programado imperativamente
    method pegaPrimero() = 
    if(jugador1.velocidad() > jugador2.velocidad()) jugador1
        
    else jugador2

    method pelea() {
        if(jugador1.vida() > 0 && jugador2.vida() > 0){
            jugadorQuePegaPrimero.atacaA(jugadorQuePegaPrimero.oponente())
            jugadorQuePegaPrimero.oponente().atacaA(jugadorQuePegaPrimero)
            self.pelea()
        }
        else
        self.terminarBatalla()
    }

    method terminarBatalla() {
        if (jugador1.vida() > 0) {
            ganador = jugador1
        } else if (jugador2.vida() > 0) {
            ganador = jugador2
        } else {
            ganador = jugadorQuePegaPrimero
        }
    }


}



    