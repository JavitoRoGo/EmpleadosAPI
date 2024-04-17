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
}

struct Network: DataInteractor, NetworkInteractor {
	static let shared = Network()
	
	private init() { }
	
	func getEmpleados() async throws -> [Empleado] {
		try await getJSON(request: .get(url: .getEmpleados), type: [EmpleadoDTO].self).map(\.toEmpleado)
		// OJO, hemos conseguido hacer la llamada en una sola línea
	}
	
	func getEmpleado(id: Int) async throws -> Empleado {
		try await getJSON(request: .get(url: .getEmpleado(id: id)), type: EmpleadoDTO.self).toEmpleado
	}
}
