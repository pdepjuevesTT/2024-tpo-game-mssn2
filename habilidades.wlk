import elementos.*
class Habilidad{
    var property position = game.at(0,0)
    var property nombre
    var property energiaQueResta = 0
    var property fuerzaExtra = 0
    var property velocidadExtra = 0
    var property danioQueCausa = 0

    method usarHabilidad(atacante,rival){
        atacante.energia(atacante.energia() - energiaQueResta) 
        atacante.cambiarImagen(atacante.imagenAtaque())
        game.schedule(5000,{atacante.cambiarImagen(atacante.imagenBatalla())})
        //self.hacerLoPropio()
        //atacante.actualizarBarras()
        //rival.actualizarBarras()
    }
   // method hacerLoPropio(){}
    method textColor() = paleta.blanco() 
    method text() = nombre
    
}


class HabilidadAtaque inherits Habilidad{
    override method usarHabilidad(atacante,rival) {
        rival.restarVida(atacante.fuerza() * danioQueCausa)
        rival.velocidad(rival.velocidad() - velocidadExtra)
        rival.fuerza(rival.fuerza() - fuerzaExtra)
        super(atacante,rival)
        
        
    }
}

class HabilidadNoOfensiva inherits Habilidad{
    var property vidaExtra = 0
    var property energiaExtra = 0
    

    override method usarHabilidad(atacante,_rival){
        atacante.vida(atacante.vida() + vidaExtra)
        atacante.energia(atacante.energia() + energiaExtra)
        atacante.fuerza(atacante.fuerza() + fuerzaExtra)
        atacante.velocidad(atacante.velocidad() + velocidadExtra)
        super(atacante,_rival)
    }
}

class Letra{
    var property text
    var property x
    var property textColor = paleta.rojo()
    var property position = game.at(x, 5)
}

//J1
const letraQ = new Letra(text = "Q.",x = 2)
const letraE = new Letra(text = "E.",x = 12)
const letraR = new Letra(text = "R.",x = 22)
const letraT = new Letra(text = "T.",x = 32)

//J2
const letraZ = new Letra(text = "Z.",x = 48)
const letraX = new Letra(text = "X.",x = 58)
const letraC = new Letra(text = "C.",x = 68)
const letraV = new Letra(text = "V.",x = 78)

const letrasCombate = [letraQ,letraE,letraR,letraT,letraZ,letraX,letraC,letraV]

