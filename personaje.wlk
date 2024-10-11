//En este documento iran todos los tipos de jugadores con su comportamiento 
class Personaje{
    var property position = game.origin()
    var property vida 
    var property energia 
    var property fuerza
    var property probabilidadDeCritico 

    method ataqueBasico1(rival) {
        rival.vida(rival.vida() - self.fuerza() * 0.1) 
        energia =- 1
        rival.esTurno()
    }

    method ataqueBasico2(rival){
        rival.vida(rival.vida() - self.fuerza() * 0.35)
        energia =- 20
        rival.esTurno()
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

const listaDePersonajes =
    [   new Guerrero(),
        new Guerrero(), 
        new Mago(),
        new Mago(),
        new Arquero(),
        new Arquero(),
        new Asesino(),
        new Asesino()]