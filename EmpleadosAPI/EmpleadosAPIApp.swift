//
//  EmpleadosAPIApp.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import SwiftUI

@main
struct EmpleadosAPIApp: App {
	@StateObject private var vm = EmpleadosVM()
	@StateObject private var network = NetworkStatus()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(vm)
				.unavailableNetwork(status: network.status)
        }
    }
}
