//
//  URL.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// CAPA DE LAS URL

// Un endpoint es como una función remota, que está y se ejecuta en otro sitio, en la API
// Lo primero que necesitamos son las urls para hacer get, post, put, etc.
// Al trabajar en red podemos necesitar varias urls generales: producción, prueba, preproducción, etc. Al menos habrá un entorno o servidor de prueba y el de producción ya con los datos reales
// Pre-producción es un entorno de prueba pero con un volcado o copia de los datos reales, que se usa antes de subir a producción algún cambio
// Esto se suele hacer con ficheros de configuración de Xcode o .plist, pero es preferible hacerlo de otra forma. Porque esto podría implicar que puedas subir a GitHub datos como contraseñas de acceso a bases de datos. Al menos hay que poner estos archivos dentro del .gitignore
// O sea, no es buena idea generar un plist para poner las urls de conexión. La forma de Julio de crear diferentes formas de trabajo es poner una variable global con la url raíz

// Siempre es mala práctica usar cadenas como parámetros, porque se nos va una letra y ya no funciona, mientras que si usamos los constructores adecuados como en este ejemplo, es más seguro y más difícil que falle. Y si falla, pues se cambia solo aquí y ya se arregla en toda la app
// Por ejemplo, con estos constructores, al usar .appending nos añade el caracter /

let prod = URL(string: "https://acacademy-employees-api.herokuapp.com/api")!
let desa = URL(string: "http://localhost:8080/api")!

let api = prod

extension URL {
	// extensiones de acceso a las urls
	static let getEmpleados = api.appending(path: "getEmpleados")
	static let empleado = api.appending(path: "empleado")
	static func getEmpleado(id: Int) -> URL {
		api.appending(path: "getEmpleado").appending(path: "\(id)")
	}
	static func findEmpleado(search: String) -> URL {
		api.appending(path: "findEmpleado").appending(path: search)
	}
	static func searchEmpleado(search: String) -> URL {
		api.appending(path: "searchEmpleado").appending(queryItems: [.search(search: search)])
	}
}

extension URLQueryItem {
	static func search(search: String) -> URLQueryItem {
		URLQueryItem(name: "search", value: search)
	}
}
