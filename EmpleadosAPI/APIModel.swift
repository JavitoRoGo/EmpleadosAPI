//
//  APIModel.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// Este DTO es el json que nos viene del servidor, de la API
struct EmpleadoDTO: Codable {
	let id: Int
	let avatar: URL
	let department: DepartmentDTO
	let firstName, lastName, email: String
	let gender: GenderDTO
	let zipcode, address: String
	let username: String
}

struct DepartmentDTO: Codable {
	let id: Int
	let name: DptoName
}

struct GenderDTO: Codable {
	let id: Int
	let gender: Gender
}

extension EmpleadoDTO {
	var toEmpleado: Empleado {
		Empleado(
			id: id,
			firstName: firstName,
			lastName: lastName,
			email: email,
			username: username,
			address: address,
			zipcode: zipcode,
			avatar: avatar,
			department: department.name,
			gender: gender.gender
		)
	}
}
