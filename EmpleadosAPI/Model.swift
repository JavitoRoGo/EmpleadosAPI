//
//  Model.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation
// revisar esto
// Este es el modelo que vamos a usar en la app

struct Empleado: Identifiable, Hashable {
	let id: Int
	let firstName: String
	let lastName: String
	let email: String
	let username: String
	let address: String
	let zipcode: String
	let avatar: URL
	let department: DptoName
	let gender: Gender
	
	var fullName: String {
		"\(lastName), \(firstName)"
	}
}

// En toda la app podemos usar [Empleado] para los datos, o usar Empleados con un typealias
typealias Empleados = [Empleado]
