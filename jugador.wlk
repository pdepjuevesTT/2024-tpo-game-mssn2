// jugador.wlk
import configuracion.*
import elementos.*
import personaje.*



class Jugador{
    var property personaje = null
}

const jugador1 = new Jugador()
const jugador2 = new Jugador()



object combate {
    var property ganador = null 
    var property personajes = null 


    method ordenarListaSegunVelocidadDeAtaque() = personajes.sortedBy({personaje1, personaje2 => personaje1.velocidad() > personaje2.velocidad()}) 
    


    method pelea() {
        const listaPersonajesOrdenada = self.ordenarListaSegunVelocidadDeAtaque() 
        if(self.todosVivos(listaPersonajesOrdenada)) {
            if (self.todosListos(listaPersonajesOrdenada)){
                self.atacan(listaPersonajesOrdenada)
                self.resetDeAtributosPostPelea(listaPersonajesOrdenada)
            }             
        }else{
            self.terminarBatalla(listaPersonajesOrdenada)
            }
}
    method todosListos(peleadores) = peleadores.all({jugador => jugador.preparado()})

    method todosVivos(peleadores) = peleadores.all({personaje => personaje.vida() > 0})

    method atacan(peleadores){
        peleadores.forEach({personaje => personaje.atacarAlResto(self.todosMenos(peleadores,personaje))}) 
    }

    method todosMenos(listaPeleadores,personaje) = listaPeleadores.filter({peleador => peleador != personaje})

    method terminarBatalla(listaPersonajesOrdenada){
        ganador = 
            if (listaPersonajesOrdenada.any({personaje =>  personaje.vida() > 0})) listaPersonajesOrdenada.max({personaje => personaje.vida()})
            else listaPersonajesOrdenada.first()
        

        const ganadorPelea = new Visual(image = "ganadorJugador"+ self.numeroJugador(self.ganador()) +".png" )
        
        game.addVisual(ganadorPelea)

        game.schedule(5000,{gameManager.cerrarJuego()})
        }
    
    method resetDeAtributosPostPelea(listaPersonajes) {
        listaPersonajes.forEach({personaje => personaje.preparado(false)})
        listaPersonajes.forEach({personaje => personaje.energia(personaje.energia() + 10)})
    }

    method numeroJugador(jugador) = if (personajes.first() == jugador) 1 else 2
}



