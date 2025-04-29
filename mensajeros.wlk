
object paquete {
  var estaPago = false
  var destino =  laMatrix
  method estaPago() = estaPago
  method pagarPaquete() {estaPago = true}
  method puedeEntregarse(unMensajero){
    return destino.dejaPasar(unMensajero) && self.estaPago()
  }
  method precioTotal() = 50
}
object puenteDeBrooklyn{
    method dejaPasar(unMensajero){
       return unMensajero.peso() < 1000
    }
  
}
object laMatrix{
    method dejaPasar(unMensajero){
        return unMensajero.puedeLlamar()
    } 
}

object roberto{
    var transporte = bicicleta
    method peso() = 90 + transporte.peso()
    method puedeLlamar() = false
    method cambiarTransporte(nuevoTransporte){
        transporte = nuevoTransporte
    }
}

object chuckNorris {
    method peso() = 80
    method puedeLlamar() = true
}

object neo {
    var tieneCredito = true
    method peso() = 0
    method puedeLlamar() = tieneCredito
    method cargarCredito(){tieneCredito = true}
    method agotarCredito() {tieneCredito = false}
}

object bicicleta {
  method peso() = 5
}
object camion {
    var acoplados = 1
    method cantidadAcoplados(unaCantidad){
        acoplados = unaCantidad
    }
    method peso(){
        acoplados * 500
    }
}

object empresaMensajeria {
  const mensajeros = [] //#{} //definicion de conjuntos
  const paquetesPendientes = []
  const paquetesEnviados = []
  method mensajeros() = mensajeros
  method contratar(unMensajero){
    mensajeros.add(unMensajero)
  }
  method despedir(unMensajero){
    mensajeros.remove(unMensajero)
  }
  method esGrande() = mensajeros.size() > 2 //si hay mas de dos mensajeros

  method  puedeEntregarsePaquete(){
    return paquete.puedeEntregarse(mensajeros.first()) // entregado por el primer mensajero
  }
  method pesoUltimoMensajero() = mensajeros.last().peso() //el peso del ultimo mensajero
 
  method puedeEntregarse(unPaquete){
    return mensajeros.any({m => unPaquete.puedeEntregarse(m)}) 
  }
  method losQuePuedenEntregar(unPaquete){
    return mensajeros.filter({m => unPaquete.puedeEntregarse(m)}) 
  }

  method pesoDeLosMensajeros() = mensajeros.sum({m => m.peso()}) //metodo auxiliar del ejercicio de abajo
  method  tieneSobrepeso(){
    return self.pesoDeLosMensajeros() / mensajeros.size() > 500
  }
  method enviar(unPaquete){
    if(self.puedeEntregarse(unPaquete)){
        paquetesEnviados.add(unPaquete)
    }
    else{
        paquetesPendientes.add(unPaquete)
    }
  }
  method facturacion() = paquetesEnviados.sum({p => p.precioTotal()}) //5
  
  method enviarPaquetes(listaDePaquetes){ //punto 6
    listaDePaquetes.forEach({p => self.enviar(p)})
  }
  method enviarPendienteMasCaro(){ //7
    if(self.puedeEntregarse(self.paquetesPendienteMasCaro())){
        self.enviar(self.paquetesPendienteMasCaro())
        paquetesPendientes.remove(self.paquetesPendienteMasCaro())
    }
  }
  method paquetesPendienteMasCaro(){
    return paquetesPendientes.max({p => p.precioTotal()})
  }
}

object paquetito{
    method estaPago() = true
    method puedeEntregarse(unMensajero) = true
    method precioTotal() = 0
}

object paquetonViajero {
    const destinos = []
    var importePagado = 0
    method agregarDestinos(unDestino){
        destinos.add(unDestino)
    } 
    method precioTotal() = 100 * destinos.size()
    method pagar(unImporte){
        importePagado = importePagado + unImporte
    }
    method estaPago(){
        return importePagado >= self.precioTotal()
    }

    method puedePasarPorDestinos(unMensajero){
        return destinos.all({d => d.dejaPasar(unMensajero)})
    }
    method puedeEntregarse(unMensajero){
        return self.estaPago() && self.puedePasarPorDestinos(unMensajero)
    }
    
}
