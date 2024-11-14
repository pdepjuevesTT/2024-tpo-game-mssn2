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
    var property imagenSelector 
    var property imagenBatalla = ""
    var property imagenAtaque = ""
    var property image = imagenSelector
    var property velocidad
    var property habilidades = []
    var property nombre  
    const property barras = []

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
        const golpe1 = new HabilidadAtaque(position = posicion1,energiaQueResta = 1, danioQueCausa=0.1,nombre = "Golpe")
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
        const barraVida = new BarraGeneral(nombre = "Vida",position = posicionBarraVida ,parametroTotal = self.vida())
        const barraEnergia = new BarraGeneral(nombre = "Energia",position = posicionBarraEnergia ,parametroTotal = self.energia()) 


        barras.addAll([barraVida,barraEnergia])
        game.addVisual(barraVida)
        game.addVisual(barraEnergia)


        barraVida.inicializarEstadosBarra()
        barraEnergia.inicializarEstadosBarra()
        self.actualizarBarras()
    }

    method actualizarBarras() {
        barras.first().actualizarBarra(vida)
        barras.last().actualizarBarra(energia)
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
    const golpe2 = new HabilidadAtaque(position =posicion2,energiaQueResta = 25, danioQueCausa = 0.4, nombre = "Espadazo" )
    const habilidad3 = new HabilidadNoOfensiva(position =posicion3,fuerzaExtra = 25, nombre = "Ganar fuerza")
    const ulti = new HabilidadAtaque(position =posicion4,energiaQueResta = 75, danioQueCausa = 1, fuerzaExtra = 1, nombre = "Super espadazo")
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
    const golpe2 = new HabilidadAtaque(position =posicion2,energiaQueResta = 30, danioQueCausa = 0.5, nombre = "Ataque Magico")
    const habilidad3 = new HabilidadNoOfensiva(position =posicion3,vidaExtra = 30, velocidadExtra = -1, nombre = "Curacion magica")
    const ulti = new HabilidadAtaque(position =posicion4,energiaQueResta = 90, danioQueCausa = 1, fuerzaExtra = 5, velocidadExtra = 3, nombre = "Super hechizo")
    habilidades.addAll([golpe2,habilidad3,ulti])
    }
}

class Arquero inherits  Personaje{
    var property municion = [1,1,1,1,3,4,2,2,1,1,1,1,1,1,1,1,2,2,0.5]

    override method fuerza() = fuerza * municion.anyOne()

    override method inicializarHabilidades(posicion1,posicion2,posicion3,posicion4) {
    super(posicion1,posicion2,posicion3,posicion4)
    const golpe2 = new HabilidadAtaque(position =posicion2,energiaQueResta = 20, danioQueCausa = 0.3, nombre = "Flechazo")
    const habilidad3 = new HabilidadNoOfensiva(position =posicion3,vidaExtra = 10,energiaExtra = 20, nombre = "Recuperarse")
    const ulti = new HabilidadAtaque(position =posicion4,energiaQueResta = 80, danioQueCausa = 0.9,velocidadExtra = 5, nombre = "Super flechazo")
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
    const golpe2 = new HabilidadAtaque(position = posicion2,energiaQueResta = 15, danioQueCausa = 0.25,nombre = "Apunialar")
    const habilidad3 = new HabilidadNoOfensiva(position = posicion3,fuerzaExtra = 10, velocidadExtra = 10, vidaExtra = 10, nombre = "Mejora atributos")
    const ulti = new HabilidadAtaque(position = posicion4,energiaQueResta = 85, danioQueCausa = 0.85,velocidadExtra = 15, nombre = "Super punialada")
    habilidades.addAll([golpe2,habilidad3,ulti])
    }      
}
