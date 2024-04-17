//
//  URLRequests.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// CAPA DE LAS REQUEST

// Son las peticiones de las llamadas
// Igual que antes, mejor hacerlo así porque podemos controlar más cosas por defecto, y luego al usar el código en la app es más fácil

extension URLRequest {
	static func get(url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Accept")
//		request.setValue("Bearer skdjfñasjdfñajsf", forHTTPHeaderField: "Authorization") esto sería para la autorización si hiciera falta, y así ya lo llevan todas las peticiones y no hay que estar repitiéndolo
		return request
	}
	
	static func post<JSON>(url: URL, post: JSON, method: HTTPMethod = .post) -> URLRequest where JSON: Codable {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = method.rawValue
		request.httpBody = try? JSONEncoder().encode(post)
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
