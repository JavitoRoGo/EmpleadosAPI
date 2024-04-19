//
//  NetworkMockInterface.swift
//  EmpleadosAPITests
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

// Tenemos que engañar al sistema para que use las funciones de llamada a red pero no vaya al servidor, sino al mock que le digamos, y así poder testear las funciones de llamada de red

final class NetworkMockInterface: URLProtocol {
	var urlGetEmpleados: URL {
		Bundle.main.url(forResource: "testEmpleados", withExtension: "json")!
	}
	
	// hay que sobrecargar 4 métodos de clase
	override class func canInit(with request: URLRequest) -> Bool {
		// devuelve un Bool en función de si se puede hacer la conexión a red. Devolvemos true directamente porque no vamos a salir a red para los tests. Da igual la llamada que pueda hacer, en el test le decimos que devuelva true para que funcione, como que la conexión fue bien
		true
	}
	
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		request // este no hace nada en especial, pero hay que ponerlo igualmente para que funcione; estamos anulando el comportamiento por defecto de esta función en la clase padre: que no ejecute nada sino que devuelva la propia request para el test
	}
	
	override func startLoading() {
		// aquí es donde va el verdadero código que devuelve el resultado que nosotros queremos
		// nos permite modificar la respuesta todo lo que queramos, simulando diferentes statusCode o lo que sea
		if let url = request.url {
			if url.lastPathComponent == "getEmpleados" {
				// llamada a getEmpleados, pues mockeamos su salida con el fichero de prueba
				guard let data = try? Data(contentsOf: urlGetEmpleados),
					  let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json; charset=utf-8"]) else { return }
				client?.urlProtocol(self, didLoad: data) // esto hace que en el data del try await de la llamada a red devuelva nuestro fichero de test. Devuelve como data de la llamada el data que obtuvimos antes
				client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			}
			// aquí usaríamos varios else if para comprobar más conexiones a otras url como getEmpleado, etc.
		}
		client?.urlProtocolDidFinishLoading(self) // es la señal que se envía al (data, response) que obtenemos en las llamadas
		// nos devuelve los datos del json del bundle como si los devolviera la llamada de red
	}
	
	override func stopLoading() { }
}
