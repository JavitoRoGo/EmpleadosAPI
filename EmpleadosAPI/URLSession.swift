//
//  URLSession.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import Foundation

// Capa de las sesiones o las llamadas, usando una url o una url-request

extension URLSession {
	func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await data(from: url)
			guard let response = response as? HTTPURLResponse else {
				throw NetworkError.nonHTTP
			}
			return (data, response)
		} catch let error as NetworkError {
			throw error
		} catch {
			throw NetworkError.general(error)
		}
	}
	
	func getData(for request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await data(for: request)
			guard let response = response as? HTTPURLResponse else {
				throw NetworkError.nonHTTP
			}
			return (data, response)
		} catch let error as NetworkError {
			throw error
		} catch {
			throw NetworkError.general(error)
		}
	}
}
