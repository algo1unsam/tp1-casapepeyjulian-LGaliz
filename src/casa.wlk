object casa{	
	var viveres = 50 //porcentual
	const valorSuficiente = 40
	var montoReparacion = 0
	
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
		return self.tieneViveresSuficientes() and self.necesitaReparaciones()
	}
}
