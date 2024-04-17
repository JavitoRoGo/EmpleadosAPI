//
//  EmpleadosVM.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import SwiftUI

// Si ponemos aquí el @MainActor hacemos que TODA la clase se ejecute en el hilo principal, que es peor idea todavía que pasar toda la función getEmpleados al hilo principal. Repetimos: si la carga de los datos lleva tiempo, pues ese tiempo estará la app y la interfaz congelada; si la carga de datos es muy rápida no hay problema, pero la mejor práctica es pasar al hilo principal solo la asignación de los datos ya descargados a nuestro almacén empleados
final class EmpleadosVM: ObservableObject {
	let interactor: DataInteractor
	
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
}
