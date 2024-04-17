//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var vm = EmpleadosVM()
	
    var body: some View {
		NavigationStack {
			Group {
				if vm.showflower {
					ProgressView()
				} else {
					List {
						ForEach(vm.empleados) { empleado in
							Text(empleado.fullName)
						}
					}
				}
			}
			.navigationTitle("Empleados")
			.alert("Network Error", isPresented: $vm.showAlert) {} message: {
				Text(vm.errorMsg)
			}
		}
    }
}

#Preview {
    ContentView()
}
