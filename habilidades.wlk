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
    }
    method textColor() = paleta.blanco() 
    method text() = nombre
    
}


class HabilidadAtaque inherits Habilidad{
    override method usarHabilidad(atacante,rival) {
        super(atacante,rival)
        rival.restarVida(atacante.fuerza() * danioQueCausa)
        rival.velocidad(rival.velocidad() - velocidadExtra)
        rival.fuerza(rival.fuerza() - fuerzaExtra)
        atacante.actualizarBarras()
        rival.actualizarBarras()
    }
}

class HabilidadNoOfensiva inherits Habilidad{
    var property vidaExtra = 0
    var property energiaExtra = 0
    

    override method usarHabilidad(atacante,_rival){
        super(atacante,_rival)
        atacante.vida(atacante.vida() + vidaExtra)
        atacante.energia(atacante.energia() + energiaExtra)
        atacante.fuerza(atacante.fuerza() + fuerzaExtra)
        atacante.velocidad(atacante.velocidad() + velocidadExtra)
        atacante.actualizarBarras()
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

class GolpeBasicoGeneral inherits HabilidadAtaque(energiaQueResta = 1, danioQueCausa=0.1,nombre = "Golpe" ){}


class GolpeGuerrero inherits HabilidadAtaque(energiaQueResta = 25, danioQueCausa = 0.4, nombre = "Espadazo" ){}
class PotenciarGuerrero inherits HabilidadNoOfensiva(fuerzaExtra = 25, nombre = "Ganar fuerza"){}
class UltiGuerrero inherits HabilidadAtaque(energiaQueResta = 75, danioQueCausa = 1, fuerzaExtra = 1, nombre = "Super espadazo"){}


class GolpeArquero inherits HabilidadAtaque(energiaQueResta = 20, danioQueCausa = 0.3, nombre = "Flechazo"){}
class RecuperacionArquero inherits HabilidadNoOfensiva(vidaExtra = 10,energiaExtra = 20, nombre = "Recuperarse"){}
class UltiArquero inherits HabilidadAtaque(energiaQueResta = 80, danioQueCausa = 0.9,velocidadExtra = 5, nombre = "Super flechazo"){}


class GolpeMago inherits HabilidadAtaque(energiaQueResta = 30, danioQueCausa = 0.5, nombre = "Ataque Magico"){}
class CuraMagica inherits HabilidadNoOfensiva(vidaExtra = 30, velocidadExtra = -1, nombre = "Curacion magica"){}
class UltiMago inherits HabilidadAtaque(energiaQueResta = 90, danioQueCausa = 1, fuerzaExtra = 5, velocidadExtra = 3, nombre = "Super hechizo"){}


class GolpeAsesino inherits HabilidadAtaque(energiaQueResta = 15, danioQueCausa = 0.25,nombre = "Apunialar"){}
class MejoraAsesino inherits HabilidadNoOfensiva(fuerzaExtra = 10, velocidadExtra = 10, vidaExtra = 10, nombre = "Mejora atributos"){}
class UltiAsesino inherits HabilidadAtaque(energiaQueResta = 85, danioQueCausa = 0.85,velocidadExtra = 15, nombre = "Super punialada"){}

