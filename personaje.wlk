import wollok.game.*
import configuracion.*
import habilidades.*

//const listaDePersonajes = [stan, carman]
class Personaje{
    var property position = game.origin()
    var property vida 
    var property energia 
    var property fuerza
   // var property probabilidadDeCritico 
    const property image 
    var property velocidad
    var property golpes = [golpeBasico]

    method colision(selector) {
        selector.jugador().personaje(self)
    }

    method atacarAlResto() {
        
      
    }

}

class Guerrero inherits Personaje(){
    var property escudo  // tambien podria ser furia que incrementa el ataque durante un tiempo un  % del ataque original  
}

class Mago inherits Personaje {
    var property magia 
}

class Arquero inherits  Personaje{
    var property municion

}

//el asesino eleva mucho el porcentaje de critico 
class Asesino inherits Personaje{
    
}

    
