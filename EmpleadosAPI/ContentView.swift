//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 16/4/24.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var vm: EmpleadosVM
	
    var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack {
					ForEach(vm.empleados) { empleado in
						NavigationLink(value: empleado) {
							EmpleadoRow(empleado: empleado)
						}
						.buttonStyle(.plain)
					}
				}
				.padding()
			}
			.navigationBarTitleDisplayMode(.inline)
			.navigationDestination(for: Empleado.self) { empleado in
				EditEmployeeView(editVM: EditEmpleadosVM(empleado: empleado))
			}
			.customNavBar(title: "Employees List")
			.addToolBarButton()
			.customAlert(showCustom: $vm.showAlert, title: "Network Error", msg: vm.errorMsg)
			.refreshable {
				await vm.getEmleados()
			}
		}
    }
}

#Preview {
	ContentView.preview
}
