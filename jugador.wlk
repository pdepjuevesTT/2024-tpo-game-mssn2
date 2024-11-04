import configuracion.*
import elementos.*
import personaje.*



class Jugador{
    var property personaje = null
}

const jugador1 = new Jugador()
const jugador2 = new Jugador()



object combate {
    var property listaPersonajesOrdenada = null
    var property ganador = null 


    method ordenarListaSegunVelocidadDeAtaque() {
    listaPersonajesOrdenada = listaPersonajesOrdenada.sortedBy({personaje1, personaje2 => personaje1.velocidad() > personaje2.velocidad()}) 
    }


    method pelea() {
        if (listaPersonajesOrdenada.all({jugador => jugador.preparado()})){
            if(listaPersonajesOrdenada.all({personaje => personaje.vida() > 0})){
                listaPersonajesOrdenada.forEach({personaje => personaje.atacarAlResto(listaPersonajesOrdenada.remove(personaje),personaje.habilidadQueVaUsar())})
                self.resetDeAtributosPostPelea(listaPersonajesOrdenada)
            }
            else{
                self.terminarBatalla()
            }
    }
}

    method terminarBatalla(){
        ganador = 
            if(listaPersonajesOrdenada.all({jugador => jugador.vida() <= 0})) listaPersonajesOrdenada.first()

            else listaPersonajesOrdenada.filter({personaje =>  personaje.vida() > 0}).max({personaje => personaje.vida()})

        
        
        game.addVisual(ganadorPelea)
        gameManager.cerrarJuego()
        }
    
    method resetDeAtributosPostPelea(listaPersonajes) {
        self.ordenarListaSegunVelocidadDeAtaque()
        listaPersonajes.forEach({personaje => personaje.preparado(false)})
        listaPersonajes.forEach({personaje => personaje.energia(personaje.energia() + 10)})
    }
}



object ganadorPelea{
    var property nombre = combate.ganador().nombre()
    
    method text() = nombre
}
