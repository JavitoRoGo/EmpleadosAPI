//
//  EmpleadosAPITests.swift
//  EmpleadosAPITests
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import XCTest
@testable import EmpleadosAPI

final class EmpleadosAPITests: XCTestCase {
	var network: Network!
	
    override func setUpWithError() throws {
		let config = URLSessionConfiguration.default
		config.protocolClasses = [NetworkMockInterface.self]
		let session = URLSession(configuration: config)
		
		network = Network(session: session)
    }
	
    override func tearDownWithError() throws {
        network = nil
    }
	
	func testLoad() async throws {
		let empleados = try await network.getEmpleados()
		XCTAssertEqual(empleados.count, 12)
	}
}
