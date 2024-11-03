import elementos.*
class Habilidad{
    var property position = game.at(0,0)
    var property nombre
    var property energiaQueResta 
    var property fuerzaExtra = 0
    var property velocidadExtra = 0
    method usarHabilidad(atacante,rival){
        if(atacante.energi() >= energiaQueResta){
            self.efectoHabilidad(atacante,rival)
        }
    }
    method text() = nombre
    method efectoHabilidad(atacante,rival){
        atacante.energia(atacante.energia() - energiaQueResta) 
    }
}


class HabilidadAtaque inherits Habilidad{
    var property danioQueCausa
    override method efectoHabilidad(atacante,rival) {
        super(atacante,rival)
        rival.vida(rival.vida() - atacante.fuerza() * danioQueCausa)
        rival.velocidad(rival.velocidad() - velocidadExtra)
        rival.fuerza(rival.fuerza() - fuerzaExtra)
    }
}

class HabilidadNoOfensiva inherits Habilidad{
    var property vidaExtra = 0
    var property energiaExtra = 0
    

    override method efectoHabilidad(atacante,_rival){
        super(atacante,_rival)
        atacante.vida(atacante.vida() + vidaExtra)
        atacante.energia(atacante.energia() + energiaExtra)
        atacante.fuerza(atacante.fuerza() + fuerzaExtra)
        atacante.velocidad(atacante.velocidad() + velocidadExtra)
    }
}

const golpeBasico = new HabilidadAtaque(energiaQueResta = 1,danioQueCausa = 0.1, nombre = "golpe normal") //ejemplo
