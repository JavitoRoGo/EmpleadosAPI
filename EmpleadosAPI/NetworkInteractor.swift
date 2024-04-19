//
//  NetworkInteractor.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// Un protocolo que nos permite hacer la funcionalidad que utilice la capa de red de URLSession, para abstraer al máximo el trabajo de red
// Este protocolo es un interactor, es decir, una capa o funcionalidad para persistencia: obtener el json con los datos y guardar el json que le pasemos en la api. Lo que hacemos aquí entonces es usar todas las extensiones de las otras capas para hacer ya la llamada en sí y obtener el json con los datos, o enviar el json con nuestros datos
// O sea, esto es la persistencia de los datos en la red: descarga y subida

protocol NetworkInteractor {
	var session: URLSession { get }
	
	// podríamos no poner aquí las especificaciones y dejar esto en blanco y también funcionaría, siempre y cuando hagamos la implementación en la extensión. Lo que pasa es que entonces esas funciones no serían requeridas
	func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable
	func postJSON(request: URLRequest) async throws // el json va dentro del request en este caso, en el body
}

extension NetworkInteractor {
	func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
		let (data, response) = try await session.getData(for: request)
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
		// no enviamos el json en este caso porque va en la cabecera del request, como httpBody
		let (_, response) = try await session.getData(for: request)
		if response.statusCode != 200 {
			throw NetworkError.status(response.statusCode)
			// lanza un error si statusCode es diferente de 200, y si sale todo bien pues no hace nada y damos por buena la operación
		}
	}
}


// Todas estas capas, estos 5 archivos de la carpeta Interface, son completamente genéricos (menos las urls) y por tanto se pueden exportar a una librería externa propia y usarlo en cualquier app
// Podemos entonces crear una librería con estos archivos, y usarlo en cualquier app creando solo los archivos URL con las urls, y Network ya con los tipos de datos propios de la app en cuestión
