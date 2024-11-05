import configuracion.*
import wollok.game.*
import personaje.*
import jugador.*


//Visuales en general//
class Visual { 
    var property position = game.origin()
    var property image  
}

class Limite inherits Visual{

    //override method image() = "pixelNegro.png"

    method colision(_selector) {
        throw new DomainException(message = "No se puede atravesar este limite")
    }
}   

const celdaArriba1 =new Limite(image = "celdaBalanca.png" , position = game.at(6,40))
const celdaArriba2 =new Limite(image = "celdaBalanca.png" , position = game.at(32,40))
const celdaArriba3 =new Limite(image = "celdaBalanca.png" , position = game.at(58,40))

const celdaArribaIzq =new Limite(image = "celdaBalanca.png" ,position = game.at(-20,27))
const celdaBajoIzq = new Limite(image = "celdaBalanca.png" ,position = game.at(-20,1))
const celdaMedioIzq= new Limite(image = "celdaBlanca.png" ,position =game.at(-20,14))

const celdaBajo1 = new Limite(image = "celdaBalanca.png" , position = game.at(6,-12)) 
const celdaBajo2 = new Limite(image = "celda",position = game.at(32,-12))
const celdaBajo3 = new Limite(image = "celda",position = game.at(58,-12))

const celdaArribaDer =new Limite(image = "pixel.jpg" ,position = game.at(84,27))
const celdaMedioDer = new Limite(image = "pixel.jpg" ,position = game.at(84,14))
const celdaBajoDer  = new Limite(image = "pixel.jpg" ,position = game.at(84,1))

const celdaLogo = new Limite(image = "pixel.jpg" ,position = game.at(32,14))

/*
en (6,1) -> personaje1
en (6,14) -> personaje2
en (6,27) -> personaje3
en (32,27) -> personaje4
en(58,27) -> personaje5
en(58,14) -> personaje6
en(58,1)->personaje7
en(32, 1) -> peronsaje8
*/


const ivar = new Guerrero(position = game.at(6,1),vida = 500,energia = 100, fuerza = 250,imagenSelector = "arqueroSelector.jpg",imagenBatalla = "arqueroSelector.jpg",imagenAtaque = "arqueroSelector.jpg",velocidad = 50,escudo = 50 , nombre = "ivar" )
const ragnar = new Guerrero(position = game.at(6,14),vida = 500,energia = 100, fuerza = 250,imagenSelector = "arqueroSelector.jpg",imagenBatalla = "arqueroSelector.jpg",imagenAtaque = "arqueroSelector.jpg",velocidad = 50,escudo = 50, nombre="ragnar" )


const menuSeleccion = new Visual (image=  "menuSeleccion.png")
const escenarioCombate1 = new Visual(image = "fondoVillaNuevo.png")
const escenarioCombate2 = new Visual(image = "")
const escenarioCombate3 = new Visual(image = "")


class Selector inherits Visual{
    var property jugador 
    var direccion = arriba

    method subir() {
    direccion = arriba
	self.avanzar()
    }

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
    const image
  
    method estaEnRango(unValor) =  unValor >= rango


    method image() = image
}

class Estado16 inherits EstadoBarra(rango = 93.75){}
class Estado15 inherits EstadoBarra(rango = 87.5){}
class Estado14 inherits EstadoBarra(rango =81.25){}
class Estado13 inherits EstadoBarra(rango =75){}
class Estado12 inherits EstadoBarra(rango =68.75){}
class Estado11 inherits EstadoBarra(rango =62.5){}
class Estado10 inherits EstadoBarra(rango =56.25){}
class Estado9 inherits EstadoBarra(rango =50){}
class Estado8 inherits EstadoBarra(rango =43.75){}
class Estado7 inherits EstadoBarra(rango =37.5){}
class Estado6 inherits EstadoBarra(rango =31.25){}
class Estado5 inherits EstadoBarra(rango =25){}
class Estado4 inherits EstadoBarra(rango =18.75){}
class Estado3 inherits EstadoBarra(rango =12.5){}
class Estado2 inherits EstadoBarra(rango =6.25){}
class Estado1 inherits EstadoBarra(rango =0){}


class BarraGeneral inherits Visual{
    var property parametroTotal  // porcentaje total del parametro que se le tiene que pasar de acuerdo a los atributos del personaje 
    var property porcentajeActual  = null
    const estados = []
    const property imagen16
    const property imagen15
    const property imagen14
    const property imagen13
    const property imagen12
    const property imagen11
    const property imagen10
    const property imagen9
    const property imagen8
    const property imagen7
    const property imagen6
    const property imagen5
    const property imagen4
    const property imagen3
    const property imagen2
    const property imagen1 

    method cambiarImagen(imagenNueva) {
      image = imagenNueva
    }

    method actualizarBarra(parametro) {
        porcentajeActual = (parametro / parametroTotal) * 100
        const estNuevo = estados.find({estado => estado.estaEnRango(porcentajeActual)})
        self.cambiarImagen(estNuevo)
    }

    method inicializarEstado() {
        const estado16 = new Estado16(image = imagen16)
        const estado15 = new Estado15(image = imagen15)        
        const estado14 = new Estado14(image = imagen16)
        const estado13 = new Estado13(image = imagen16)
        const estado12 = new Estado12(image = imagen16)
        const estado11 = new Estado11(image = imagen16)
        const estado10 = new Estado10(image = imagen16)
        const estado9  = new Estado9  (image = imagen16)
        const estado8  = new Estado8  (image = imagen16)
        const estado7  = new Estado7  (image = imagen16)
        const estado6  = new Estado6  (image = imagen16)
        const estado5  = new Estado5  (image = imagen16)
        const estado4  = new Estado4  (image = imagen16)
        const estado3  = new Estado3  (image = imagen16)
        const estado2  = new Estado2  (image = imagen16)
        const estado1  = new Estado1  (image = imagen16)

        estados.addAll([estado16,estado15,estado14,estado13,estado12,estado11,estado10,estado9,estado8,estado7,estado6,estado5,estado4,estado3,estado2,estado1])}
        
}

class BarraVida inherits BarraGeneral(
    imagen16 = "barraVida16.png",
    imagen15 = "barraVida15.png", 
    imagen14 = "barraVida14.png",
    imagen13 = "barraVida13.png",
    imagen12 = "barraVida12.png",
    imagen11 = "barraVida11.png",
    imagen10 = "barraVida10.png",
    imagen9  = "barraVida9.png",
    imagen8  = "barraVida8.png",
    imagen7 = "barraVida7.png",
    imagen6 = "barraVida6.png",
    imagen5 = "barraVida5.png",
    imagen4 = "barraVida4.png",
    imagen3 = "barraVida3.png",
    imagen2 = "barraVida2.png",
    imagen1 = "barraVida1.png"
    ){
        
}

class BarraEnergia inherits BarraGeneral(
    imagen16 = "barraEnergia16.png",
    imagen15 = "barraEnergia15.png", 
    imagen14 = "barraEnergia14.png",
    imagen13 = "barraEnergia13.png",
    imagen12 = "barraEnergia12.png",
    imagen11 = "barraEnergia11.png",
    imagen10 = "barraEnergia10.png",
    imagen9 = "barraEnergia9.png",
    imagen8 = "barraEnergia8.png",
    imagen7 = "barraEnergia7.png",
    imagen6 = "barraEnergia6.png",
    imagen5 = "barraEnergia5.png",
    imagen4 = "barraEnergia4.png",
    imagen3 = "barraEnergia3.png",
    imagen2 = "barraEnergia2.png",
    imagen1 = "barraEnergia1.png"
    ){     
}

class BarraEscudo inherits BarraGeneral(
    imagen16 = "barraEscudo16.png",
    imagen15 = "barraEscudo15.png", 
    imagen14 = "barraEscudo14.png",
    imagen13 = "barraEscudo13.png",
    imagen12 = "barraEscudo12.png",
    imagen11 = "barraEscudo11.png",
    imagen10 = "barraEscudo10.png",
    imagen9 = "barraEscudo9.png",
    imagen8 = "barraEscudo8.png",
    imagen7 = "barraEscudo7.png",
    imagen6 = "barraEscudo6.png",
    imagen5 = "barraEscudo5.png",
    imagen4 = "barraEscudo4.png",
    imagen3 = "barraEscudo3.png",
    imagen2 = "barraEscudo2.png",
    imagen1 = "barraEscudo1.png"
    ){
        
}

class BarraMagia inherits BarraGeneral(
    imagen16 = "barraMagia16.png",
    imagen15 = "barraMagia15.png", 
    imagen14 = "barraMagia14.png",
    imagen13 = "barraMagia13.png",
    imagen12 = "barraMagia12.png",
    imagen11 = "barraMagia11.png",
    imagen10 = "barraMagia10.png",
    imagen9 = "barraMagia9.png",
    imagen8 = "barraMagia8.png",
    imagen7 = "barraMagia7.png",
    imagen6 = "barraMagia6.png",
    imagen5 = "barraMagia5.png",
    imagen4 = "barraMagia4.png",
    imagen3 = "barraMagia3.png",
    imagen2 = "barraMagia2.png",
    imagen1 = "barraMagia1.png"
    ){
        
}

class BarraMunicion inherits BarraGeneral(
    imagen16 = "barraVida16.png",
    imagen15 = "barraVida15.png", 
    imagen14 = "barraVida14.png",
    imagen13 = "barraVida13.png",
    imagen12 = "barraVida12.png",
    imagen11 = "barraVida11.png",
    imagen10 = "barraVida10.png",
    imagen9 = "barraVida9.png",
    imagen8 = "barraVida8.png",
    imagen7 = "barraVida7.png",
    imagen6 = "barraVida6.png",
    imagen5 = "barraVida5.png",
    imagen4 = "barraVida4.png",
    imagen3 = "barraVida3.png",
    imagen2 = "barraVida2.png",
    imagen1 = "barraVida1.png"
    ){
        
}
