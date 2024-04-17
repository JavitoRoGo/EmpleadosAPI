//
//  Network.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

protocol DataInteractor {
	func getEmpleados() async throws -> [Empleado]
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
