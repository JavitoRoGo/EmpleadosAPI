//
//  Network.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// Este interactor es el encargado de la persistencia dentro de la app. Es el que creamos de forma particular para nuestra app y que trabaja con los modelos de datos propios para esta app
// Lo que hace es usar el interactor de red o Network Interactor (la librería si la tenemos creada) para cargar los datos desde la red a la capa de presentación

protocol DataInteractor {
	func getEmpleados() async throws -> Empleados
	func getEmpleado(id: Int) async throws -> Empleado
	func updateEmpleado(_ empleado: Empleado) async -> Bool
}

struct Network: DataInteractor, NetworkInteractor {
	// creamos un protocolo propio para que lo reciba URLSession en lugar del .shared, y así pasarle otro protocolo en los tests
	// y si no lo especificamos, pues que coja el .shared
	
	static let shared = Network()
	
	let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func getEmpleados() async throws -> [Empleado] {
		try await getJSON(request: .get(url: .getEmpleados), type: [EmpleadoDTO].self).map(\.toEmpleado)
		// OJO, hemos conseguido hacer la llamada en una sola línea
	}
	
	func getEmpleado(id: Int) async throws -> Empleado {
		try await getJSON(request: .get(url: .getEmpleado(id: id)), type: EmpleadoDTO.self).toEmpleado
	}
	
	func updateEmpleado(_ empleado: Empleado) async -> Bool {
		do {
			try await postJSON(
				request: .post(
					url: .empleado,
					post: empleado.toUpdate,
					method: .put
				)
			)
			return true
		} catch {
			return false
		}
	}
}
