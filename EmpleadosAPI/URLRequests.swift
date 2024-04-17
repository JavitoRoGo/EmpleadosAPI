//
//  URLRequests.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// CAPA DE LAS REQUEST

// Son las peticiones de la url, es construir las llamadas
// Igual que antes, mejor hacerlo así porque podemos controlar más cosas por defecto, y luego al usar el código en la app es más fácil

extension URLRequest {
	static func get(url: URL) -> URLRequest {
		// lo que ponemos aquí forma parte de la cabecera de la url, que son parámetros que hay definir y que no van en la propia url
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Accept") // esto significa que como respuesta aceptamos ficheros json
//		request.setValue("Bearer skdjfñasjdfñajsf", forHTTPHeaderField: "Authorization") esto sería para la autorización si hiciera falta, y así ya lo llevan todas las peticiones y no hay que estar repitiéndolo
		return request
	}
	
	static func post<JSON>(url: URL, post: JSON, method: HTTPMethod = .post) -> URLRequest where JSON: Codable {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = method.rawValue
		request.httpBody = try? JSONEncoder().encode(post) // en el body se pasan los datos que enviamos a la url como parte del post
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") // aquí definimos el tipo que le vamos a enviar
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
}

enum HTTPMethod: String {
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
	case patch = "PATCH"
}

// El uso sería así:
//URLSession.shared.dataTask(with: .get(url: .getEmpleados))
