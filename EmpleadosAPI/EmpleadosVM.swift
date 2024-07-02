//
//  EmpleadosVM.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Combine
import SwiftUI

// Veamos un ejemplo de VM de cómo sería si quisiéramos separar la lógica de los datos de la lógica de la vista. O sea, la clase EmpleadosVM que hemos usado en toda la app pasaría a llamarse EmpleadosLogic, y tendría toda la lógica de los datos. Y sacaríamos de ahí las propiedades de showAlert y errorMsg por pertenecer al viewmodel de la vista
// Y creamos un nuevo viewmodel EmpleadosVM para gestionar la lógica de la vista, y que tiene que contener una instancia del viemodel con la lógica para poder acceder a los datos. Lo que ocurre con esta forma de trabajo es que los Published de EmpleadosLogic no son recibidos por el nuevo EmpleadosVM, ya que no contiene ningún StateObject, ObservedObject o EnvironmentObject dentro de una vista, que sí serían capaces de recibir esa señal del objectWillChange
// Un ObservableObject no es capaz de relanzar una señal: el Published de empleados sí emite cuando se hace la carga, pero la instancia logic no lo recibe y no puede relanzarlo
// Por eso habría que hacer un truco o hack usando suscriptores de Combine para poder "escuchar" los publicadores de los Published de EmpleadosLogic. Funcionaría bien, pero sería un ejemplo claro de incumplimiento de la norma de "don't fight the framework"

//final class EmpleadosVM: ObservableObject {
//	let logic: EmpleadosLogic
//	
//	var subscribers = Set<AnyCancellable>() // AnyCancellable es el tipo genérico de cualquier suscriptor de Combine
//	// hay que almacenarlo aquí porque un suscriptor no va a funcionar si no está almacenado en una propiedad de la clase, porque se perdería
//	// y así existe mientras exista la instancia de la clase
//	
//	@Published var showAlert = false
//	@Published var errorMsg = ""
//	
//	init(logic: EmpleadosLogic = EmpleadosLogic()) {
//		self.logic = logic
//		logic.objectWillChange.sink {
//			// esto lo que hace es suscribirse al objectWillChange de logic y almacenarlo en subscribers, para luego hacer un send de ese objectWillChange y que ya pueda ser escuchado por la vista
//			self.objectWillChange.send()
//			// capturo el objectWillChange que viene de EmpleadosLogic, y luego hago send del objectWillChange de EmpleadosVM
//		}
//		.store(in: &subscribers)
//	}
//	// con esto ya tendríamos la lógica de los datos aparte de la lógica de la vista
//}




// Si ponemos aquí el @MainActor hacemos que TODA la clase se ejecute en el hilo principal, que es peor idea todavía que pasar toda la función getEmpleados al hilo principal. Repetimos: si la carga de los datos lleva tiempo, pues ese tiempo estará la app y la interfaz congelada; si la carga de datos es muy rápida no hay problema, pero la mejor práctica es pasar al hilo principal solo la asignación de los datos ya descargados a nuestro almacén empleados
final class EmpleadosVM: ObservableObject {
	let interactor: DataInteractor
	
	// Recordar que el almacén de los datos publicados tienen que estar en un objeto observable lo más cerca posible de la vista: tiene que recibir su señal un StateObject, EnvironmentObject o ObservedObject. Si se recoge en otra clase aunque sea ObservableObject no se reemiten sus publicadores
	@Published var empleados: Empleados = [] // inicializamos a vacío porque son datos asíncronos que viene de la red
	@Published var showAlert = false
	@Published var errorMsg = ""
	
	init(interactor: DataInteractor = Network.shared) {
		self.interactor = interactor
		// en este contexto no hay prioridad así que se la definimos; y ponemos la máxima porque es la que trae los datos al iniciar la app
		Task(priority: .high) { await getEmleados() }
	}
	
	//@MainActor // con esto le decimos que esta función sucede sobre el actor del hilo principal. Es la solución menos idónea para arreglar el error morado que sale en la línea de declaración de empleados, que nos dice que estaríamos actualizando la interfaz desde otro hilo. El problema de esto es que estamos cargado los datos desde el hilo principal, y como la carga tarde pues paramos el hilo principal
	func getEmleados() async {
		// también podemos poner aquí el Task para que la función no sea async y en el init no poner el Task
		do {
//			self.empleados = try await interactor.getEmpleados() en esta línea actualizamos los datos, y la vista, desde otro hilo que no es el principal (por el Task del init), y nos daría el error morado
			let empleados = try await interactor.getEmpleados()
			await MainActor.run {
				self.empleados = empleados
			}
		} catch {
			await MainActor.run {
				errorMsg = error.localizedDescription
				showAlert = true
			}
		}
	}
	// La forma mejor de solucionarlo es recuperar los datos en una variable en local y ya luego llamar al MainActor para actualizar los datos: líneas 31-34, y también lo del catch porque estamos modificando valores que van a la interfaz
//	MainActor es una clase que permite elevar la ejecución al hilo principal, que es donde se ejecuta todo el código de las vistas
	
	func updateEmpleado(_ empleado: Empleado) {
		if let index = empleados.firstIndex(where: { $0.id == empleado.id }) {
			empleados[index] = empleado
		}
	}
	
	func updateEmpleadoAPI(_ empleado: Empleado) async -> Bool {
		await interactor.updateEmpleado(empleado)
	}
}
