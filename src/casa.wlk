object casa{	
	var property viveres = 50 //porcentual
	const valorSuficiente = 40
	var property montoReparacion = 0
	var property cuenta
	var property tipoMantenimiento
	
	method asignarCuenta(unaCuenta){
		cuenta = unaCuenta
	}
	method tieneViveresSuficientes(){
		return viveres > valorSuficiente
	}
	
	method necesitaReparaciones(){
		return montoReparacion > 0	
	}
	
	method montoReparacion(valor){
		montoReparacion = valor
	}
	
	method viveres(valor){
		viveres = valor
	}
	
	method estaEnOrden(){
		return self.tieneViveresSuficientes() and not self.necesitaReparaciones()
	}
	
	method gastar(valor){
		cuenta.extraer(valor)
	}
	
	method comprarLoQeueSeNecesita(calidad){
		//const viveresRestantes = valorSuficiente - viveres
	    self.gastar((valorSuficiente - viveres) * calidad)
		viveres(valorSuficiente)
	}
	
	method reparar(){
		if((cuenta.saldo() > montoReparacion) and (cuenta.saldo() - montoReparacion) > 1000){
			self.gastar(montoReparacion)			
			montoReparacion = 0
		} 
	}
	
}

object cuentaCorriente{
	var property saldo = 0
	
	method depositar(valor){
//		saldo = saldo + valor
		saldo += valor
	}
	
	method extraer(valor){
		saldo -= valor
	}
}
object cuentaConGasto{
	var saldo = 0
	var costoOperacion
	
	method depositar(valor){
		saldo += valor - costoOperacion
	}
	
	method saldo(){
		return saldo
	}
	
	method extraer(valor){
		saldo -= valor
	}
	method costoOperacion(valor){
		costoOperacion = valor
	}
}

object cuentaCombinada{
	var property primaria 
	var property secundaria

//PROPERTY
//	method primaria(cuenta){
//		primaria = cuenta
//	}
//	method primaria(){
//		return primaria
//	}
	
	method depositar(valor){
		primaria.depositar(valor)
	}

	method extraer(valor){
		if(primaria.saldo() > valor){
			primaria.extraer(valor)
		}
		else secundaria.extraer(valor)
	}
	method saldo() {
		return primaria.saldo() + secundaria.saldo()
	}
}

object minimo{
	var calidad
	method mantenimiento(casa){
		if(not casa.tieneViveresSuficientes()){
			casa.comprarLoQeueSeNecesita(calidad)
		}
	}
}

object full{
	var calidad = 5
	var viveresCompletos = 100
	
	method mantenimiento(casa){		
		if(casa.estaEnOrden()){
			const viveresRestantes = viveresCompletos - casa.viveres()
			casa.viveres(viveresCompletos)
			casa.gastar(viveresRestantes * calidad)		
			}
		else{
			casa.viveres(40 + casa.viveres())
			casa.gastar(40 * calidad)
			}
		casa.reparar()
	}
}