//
//  PreviewData.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import Foundation

// Vamos a hacer que todas la preview tiren del json con datos de test cargando este DataInteractor en el VM

struct DataTestPreview: DataInteractor {
	// este interactor es el que carga los datos en VM, así que lo inyectamos en la preview y le decimos aquí que tire del json en local
	func getEmpleados() async throws -> Empleados {
		guard let url = Bundle.main.url(forResource: "testEmpleados", withExtension: "json") else { return [] }
		let data = try Data(contentsOf: url)
		return try JSONDecoder().decode([EmpleadoDTO].self, from: data).map(\.toEmpleado)
	}
	
	func getEmpleado(id: Int) async throws -> Empleado {
		.test
	}
}

extension Empleado {
	static let test = Empleado(id: 1, firstName: "Julio César", lastName: "Fernández", email: "jcfmunoz@icloud.com", username: "jcfmunoz", address: "", zipcode: "", avatar: URL(string: "www.apple.com")!, department: .engineering, gender: .male)
}
