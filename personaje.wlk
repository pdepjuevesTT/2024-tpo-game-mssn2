import wollok.game.*
import configuracion.*

//En este documento iran todos los tipos de jugadores con su comportamiento 
class Personaje{
    var property position = game.origin()
    var property vida 
    var property energia 
    var property fuerza
    var property probabilidadDeCritico 
    const property image 
    var property velocidad


    method ataqueBasico1(rival) {
        rival.vida(rival.vida() - self.fuerza() * 0.1) 
        energia =- 1
    }

    method ataqueBasico2(rival){
        rival.vida(rival.vida() - self.fuerza() * 0.35)
        energia =- 20
    }

    method ataqueUlti(rival) {
        rival.vida(rival.vida() - self.fuerza())
        energia =- 90
    }

    method habilidadNoOfensiva(){
    energia =+ 25

    }
}

class Guerrero inherits Personaje{
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

const listaDePersonajes = [stan, carman]
    

const stan = new Guerrero(
            position = game.at(-10, 1),
            velocidad =100,
            escudo = 100,
            fuerza =100,
            vida =100,
            energia =100,
            probabilidadDeCritico =100,
            image ="stanMejorado.png"

)
const carman = new Guerrero(
            position = game.at(35, 1),
            escudo = 100,
            velocidad =100,
            fuerza =100,
            vida =100,
            energia =100,
            probabilidadDeCritico =100,
            image ="carmanMejorado.png"
)