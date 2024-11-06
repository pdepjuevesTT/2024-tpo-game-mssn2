import wollok.game.*
import configuracion.*
import habilidades.*
import elementos.*

class Personaje{
    var property position = game.origin()
    var property vida 
    var property energia 
    var property fuerza
    var property preparado = false
    var property habilidadQueVaUsar = null
   // var property probabilidadDeCritico 
    var property imagenSelector 
    var property imagenBatalla = null
    var property imagenAtaque = null
    var property image = imagenSelector
    var property velocidad
    var property habilidades = []
    var property nombre  
    //const property barras = []
    var property barraVida = null
    var property barraEnergia = null

    method cambiarImagen(nuevaImagen) {
      image = nuevaImagen
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
    method atacarAlResto(otrosJugadores){
        if(habilidadQueVaUsar.danioQueCausa() != 0 ){ //se distingue si es una habilidad ofensiva o no 
        otrosJugadores.forEach({enemigo => habilidadQueVaUsar.usarHabilidad(self, enemigo)})}
        else {
            habilidadQueVaUsar.usarHabilidad(self,null)
        }
    }

    method inicializarPersonaje(direccion) {
      imagenBatalla = nombre + "2" + direccion + ".png"
      imagenAtaque = nombre + "Atacando" + direccion + ".gif"
    }

    method inicializarBarras(posicionBarraVida,posicionBarraEnergia,posicionBarraExtra) {
      barraVida = new BarraVida(position = posicionBarraVida,image = "barraVida16.png",parametroTotal = self.vida())
      barraEnergia = new BarraVida(position = posicionBarraEnergia,image = "barraEnergia16.png",parametroTotal = self.energia())
      /*
      barras.addAll([barraVida,BarraEnergia])
      barras.forEach({barra => barra.addVisual(barra)})
      */
      game.addVisual(barraVida)
      game.addVisual(barraEnergia)
    }

    method actualizarBarras() {
      barraVida.actualizarBarra(self.vida())
      barraEnergia.actualizarBarra(self.energia())
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

    override method fuerza() = fuerza + magia 

    override  method atacarAlResto(otrosJugadores){
        super(otrosJugadores)
        magia = (magia - 10).max(0)
    }

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeMago(position =posicion2)
    const habilidad3 = new CuraMagica(position =posicion3)
    const ulti = new UltiMago(position =posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }
}

class Arquero inherits  Personaje{
    var property municion = [1,1,1,1,3,4,2,2,1,1,1,1,1,1,1,1,2,2]

    override method fuerza() = fuerza * municion.anyOne()

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeArquero(position =posicion2)
    const habilidad3 = new RecuperacionArquero(position =posicion3)
    const ulti = new UltiArquero(position =posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }   

}

class Asesino inherits Personaje{
    var property potenciaDeVelocidad

    override method velocidad() = velocidad * potenciaDeVelocidad

    override  method atacarAlResto(otrosJugadores){
        super(otrosJugadores)
        potenciaDeVelocidad = (potenciaDeVelocidad - 10).max(1)
    }

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new GolpeAsesino(position = posicion2)
    const habilidad3 = new MejoraAsesino(position = posicion3)
    const ulti = new UltiAsesino(position = posicion4)
    habilidades.addAll([golpe2,habilidad3,ulti])
    }      
}

    
