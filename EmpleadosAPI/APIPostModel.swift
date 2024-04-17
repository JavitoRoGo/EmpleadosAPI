//
//  APIPostModel.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// Estos son modelos que no vamos a usar en la app, pero nos hacen falta para enviar las peticiones de búsqueda y update a la API, así que tenemos que tenerlos preparados previamente

struct EmpleadosQuery: Codable {
	var firstName: String?
	var lastName: String?
	var email: String?
}

struct EmpleadosUpdate: Codable {
	var id: Int
	var username: String?
	var firstName: String?
	var lastName: String?
	var email: String?
	var address: String?
	var avatar: String?
	var zipcode: String?
	var department: String?
	var gender: String?
}

extension Empleado {
	var toUpdate: EmpleadosUpdate {
		EmpleadosUpdate(id: id,
						username: username,
						firstName: firstName,
						lastName: lastName,
						email: email,
						address: address,
						avatar: avatar.absoluteString,
						zipcode: zipcode,
						department: department.rawValue,
						gender: gender.rawValue
		)
	}
}
