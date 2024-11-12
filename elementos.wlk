import configuracion.*
import wollok.game.*
import personaje.*
import jugador.*


//Visuales en general//
class Visual { 
    var property position = game.origin()
    var property image  
}

class Limite{
    var property position

    //override method image() = "pixelNegro.png"

    method colision(_selector) {
        throw new DomainException(message = "No se puede atravesar este limite")
    }
}   

//le saque las imagenes ya que son pixeles invicibles por eso no tienen imagen 
const celdaArriba1 =new Limite(position = game.at(6,40))
const celdaArriba2 =new Limite(position = game.at(32,40))
const celdaArriba3 =new Limite(position = game.at(58,40))

const celdaArribaIzq =new Limite(position = game.at(-20,27))
const celdaBajoIzq = new Limite(position = game.at(-20,1))
const celdaMedioIzq= new Limite(position =game.at(-20,14))

const celdaBajo1 = new Limite(position = game.at(6,-12)) 
const celdaBajo2 = new Limite(position = game.at(32,-12))
const celdaBajo3 = new Limite(position = game.at(58,-12))

const celdaArribaDer =new Limite(position = game.at(84,27))
const celdaMedioDer = new Limite(position = game.at(84,14))
const celdaBajoDer  = new Limite(position = game.at(84,1))

const celdaLogo = new Limite(position = game.at(32,14))


const ivar = new Guerrero(position = game.at(6,1),vida = 550,energia = 100, fuerza = 250,imagenSelector = "ivarInicio.png",velocidad = 51,escudo = 50 , nombre = "ivar" )
const ragnar = new Guerrero(position = game.at(6,14),vida = 600,energia = 100, fuerza = 200,imagenSelector = "ragnarInicio2.png",velocidad = 50,escudo = 100, nombre="ragnar" )
const legolas = new Arquero(position = game.at(6,27),vida = 250, energia = 150, fuerza = 125, imagenSelector = "legolasInicio.png",velocidad = 81, nombre = "legolas")
const dibu = new Arquero(position = game.at(58,1),vida = 300, energia = 150, fuerza = 100, imagenSelector = "dibuInicio.png",velocidad = 80, nombre = "dibu")
const harry = new Mago(position = game.at(32,27),vida = 450, energia = 200, fuerza = 300, imagenSelector = "harryInicial.png", velocidad = 76, nombre = "harry", magia = 100)
const ron = new Mago(position = game.at(58,27),vida = 400, energia = 200, fuerza = 350, imagenSelector = "ronInicial.png", velocidad = 75, nombre = "ron", magia = 80)
const ezio = new Asesino(position = game.at(58,14),vida = 500, energia = 175, fuerza = 150, imagenSelector = "ezioInicio", velocidad = 1, nombre = "ezio",potenciaDeVelocidad = 100)
const desmond = new Asesino(position = game.at(32,1),vida = 475, energia = 175, fuerza = 175, imagenSelector = "desmondInicio", velocidad = 1, nombre = "desmond", potenciaDeVelocidad = 110)

const menuSeleccion = new Visual (image =  "menuSeleccion.png")
const escenarioCombate1 = new Visual(image = "fondoVillaNuevo.png")
const escenarioCombate2 = new Visual(image = "")
const escenarioCombate3 = new Visual(image = "")


class Selector inherits Visual{
    var property jugador 
    var direccion = arriba


    method moverse(nuevaDireccion) {
    direccion = nuevaDireccion
	self.avanzar()
    }
/* mo son necesarios asi es mas simple
    method subir() {
       self.moverse(arriba)
    }
//simplificar

    method bajar() {
    direccion = abajo
	self.avanzar()
    }

    method irDerecha() {
    direccion = derecha
	self.avanzar()
    }

    method irIzquierda() {
    direccion = izquierda
	self.avanzar()
    } 
    */
    method avanzar() {
		position = direccion.siguiente(position)
	}

    method retrocede() {
		position = direccion.opuesto().siguiente(position)
    }

    method colision(_selector){} //solo por el hecho de que un selector puede colisionar con otro 

    method colisiona(elemento) {
        try{
        elemento.colision(self)}
        catch e{
            self.retrocede()
            throw e        
        }
    }
}

// Sacar el 13 a algun lado
const offset = 13
object izquierda{ 
	method siguiente(position) = position.left(26) 
	method opuesto() = derecha
}

object derecha{ 
	method siguiente(position) = position.right(26) 
	method opuesto() = izquierda
}

object abajo{ 
	method siguiente(position) = position.down(13) 
	method opuesto() = arriba
}

object arriba{ 
	method siguiente(position) = position.up(13) 
	method opuesto() = abajo
}


object paleta{
    const property blanco = "FFFFFFFF"   
    const property negro = "000000FF"    
    const property rojo = "FF0000FF"     
    const property verde = "00FF00FF"    
    const property amarillo = "FFFF00FF" 
}



const selector1 = new Selector(position = game.at(6,1) ,image = "selectorAzul.png", jugador = jugador1)
const selector2 = new Selector(position = game.at(58, 1), image = "selectorVerde.png", jugador = jugador2)


class EstadoBarra {
    const rango
    const property numero 
  
    method estaEnRango(unValor) =  unValor >= rango

}

object generadorDeEstados {
  method estados(){
    const a = (16..1).map({ i => self.estado(i) })
  }
  method estado(i) = new EstadoBarra(rango = i * 6.25, numero = i )
}

class BarraGeneral inherits Visual{
    var property parametroTotal  // porcentaje total del parametro que se le tiene que pasar de acuerdo a los atributos del personaje 
    var property porcentajeActual  = null
    var property nombre 
    var property estNuevo = image 
    const property estados = []
    method cambiarImagen(imagenNueva) {
      image = imagenNueva
    }

    method inicializarBarra(){
        const a = (16..1).map({ i => self.estado(i) })
        estados.addAll([a])
    }

    method estado(i) = new EstadoBarra(rango = i * 6.25, numero = i )

    method actualizarBarra(parametro) {
        porcentajeActual = (parametro / parametroTotal) * 100
        estNuevo = nombre + self.numeroDeEstado(porcentajeActual) + ".png"
        self.cambiarImagen(estNuevo)
    }

    method numeroDeEstado(valor) = estados.find({estado => estado.estaEnRango(valor)}).numero()
}


/*
class BarraVida inherits BarraGeneral{
        
}

class BarraEnergia inherits BarraGeneral{     
}

class BarraEscudo inherits BarraGeneral{
        
}

class BarraMagia inherits BarraGeneral{
        
}

class BarraMunicion inherits BarraGeneral{
}
*/ // no necesarias porque todas funcionan de la misma manera solo varian el parametro que resiven 

