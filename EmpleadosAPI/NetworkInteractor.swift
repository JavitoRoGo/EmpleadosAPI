//
//  NetworkInteractor.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// Un protocolo que nos permite hacer la funcionalidad que utilice la capa de red de URLSession, para abstraer al máximo el trabajo de red

protocol NetworkInteractor {
	// podríamos no poner aquí las especificaciones y dejar esto en blanco y también funcionaría, siempre y cuando hagamos la implementación en la extensión
	func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable
	func postJSON(request: URLRequest) async throws // el json va dentro del request en este caso, en el body
}

extension NetworkInteractor {
	func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
		let (data, response) = try await URLSession.shared.getData(for: request)
		if response.statusCode == 200 {
			do {
				return try JSONDecoder().decode(type, from: data)
			} catch {
				throw NetworkError.json(error)
			}
		} else {
			throw NetworkError.status(response.statusCode)
		}
	}
	
	func postJSON(request: URLRequest) async throws {
		// aquí no nos interesa el data, sino que la respuesta sea correcta
		let (_, response) = try await URLSession.shared.getData(for: request)
		if response.statusCode != 200 {
			throw NetworkError.status(response.statusCode)
		}
	}
}


// Todas estas capas, estos 5 archivos de la carpeta Interface, son completamente genéricos (menos las urls) y por tanto se pueden exportar a una librería externa propia y usarlo en cualquier app
// Podemos entonces crear una librería con estos archivos, y usarlo en cualquier app creando los archivos URL y Network
