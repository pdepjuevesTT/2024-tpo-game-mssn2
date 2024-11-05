import wollok.game.*
import configuracion.*
import habilidades.*

class Personaje{
    var property position = game.origin()
    var property vida 
    var property energia 
    var property fuerza
    var property preparado = false
    var property habilidadQueVaUsar = null
   // var property probabilidadDeCritico 
    var property imagenSelector 
    var property imagenBatalla 
    var property imagenAtaque
    var property image = imagenSelector
    var property velocidad
    var property habilidades = []
    var property nombre  

    method cambiarImagenBatalla() {
      image = imagenBatalla
    }

    method cambiarImagenAtaque() {
      image = imagenAtaque
    }

    method colision(selector) {
        selector.jugador().personaje(self)
    }

    method restarVida(numero) {
    vida = vida - numero
    }

    method puedeUsarHabilidad(habilidad) = self.energia() >= habilidad.energiaQueResta()

    method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4){
        const golpe1 = new GolpeBasicoGeneral(position = posicion1)
        habilidades.add(golpe1)
    }

    method listoParaPelear(habilidad) {
            if (self.puedeUsarHabilidad(habilidad)){
                preparado = true 
                habilidadQueVaUsar = habilidad
            }   
            else{
                game.say(self, "No tengo energia suficiente. Elegir otra habilidad.")
            }  
        }
    method atacarAlResto(otrosJugadores,habilidad){
        if(habilidad.danioQueCausa() != 0 ){ //se distingue si es una habilidad ofensiva o no 
        otrosJugadores.forEach({enemigo => habilidad.usarHabilidad(self, enemigo)})}
        else {
            habilidad.usarHabilidad(self,null)
        }
    }

}

class Guerrero inherits Personaje{
    var property escudo  

    override method restarVida(numero){
        if(escudo > 0){
            escudo = escudo - numero
        }
        else{
            super(numero)
            escudo = 0
        }
    }

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeGuerrero(position =posicion2)
    const habilidad3 = new PotenciarGuerrero(position =posicion3)
    const ulti = new UltiGuerrero(position =posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }
}

class Mago inherits Personaje {
    var property magia 

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeMago(position =posicion2)
    const habilidad3 = new CuraMagica(position =posicion3)
    const ulti = new UltiMago(position =posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }
}

class Arquero inherits  Personaje{
    var property municion

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeArquero(position =posicion2)
    const habilidad3 = new RecuperacionArquero(position =posicion3)
    const ulti = new UltiArquero(position =posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }   

}

class Asesino inherits Personaje{

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeAsesino(position = posicion2)
    const habilidad3 = new MejoraAsesino(position = posicion3)
    const ulti = new UltiAsesino(position = posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }      
}

    
