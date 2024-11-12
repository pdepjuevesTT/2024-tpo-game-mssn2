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


    method ordenarListaSegunVelocidadDeAtaque() {
     return personajes.sortedBy({personaje1, personaje2 => personaje1.velocidad() > personaje2.velocidad()}) 
    }


    method pelea() {
        var listaPersonajesOrdenada = self.ordenarListaSegunVelocidadDeAtaque()
        if(listaPersonajesOrdenada.all({personaje => personaje.vida() > 0})){
            //delegar
             if (listaPersonajesOrdenada.all({jugador => jugador.preparado()})){
                //filter != yo
                listaPersonajesOrdenada.forEach({personaje => personaje.atacarAlResto(listaPersonajesOrdenada.remove(personaje))})
                self.resetDeAtributosPostPelea(listaPersonajesOrdenada)
            }
        }else{
            self.terminarBatalla()
            }
}

    method terminarBatalla(){
        var listaPersonajesOrdenada = self.ordenarListaSegunVelocidadDeAtaque()
        ganador = 
            if(listaPersonajesOrdenada.all({jugador => jugador.vida() <= 0})) listaPersonajesOrdenada.first()

            else listaPersonajesOrdenada.filter({personaje =>  personaje.vida() > 0}).max({personaje => personaje.vida()})
        
        game.addVisual(ganadorPelea)

        game.schedule(10000,{gameManager.cerrarJuego()})
        }
    
    method resetDeAtributosPostPelea(listaPersonajes) {
        self.ordenarListaSegunVelocidadDeAtaque()
        listaPersonajes.forEach({personaje => personaje.preparado(false)})
        listaPersonajes.forEach({personaje => personaje.energia(personaje.energia() + 10)})
    }
}



object ganadorPelea{
    method text() = combate.ganador().nombre()
}
