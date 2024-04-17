//
//  EditEmployeeView.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

struct EditEmployeeView: View {
	@ObservedObject var editVM: EditEmpleadosVM
	
    var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading) {
				Section {
					SaiyanTextField(label: "First Name", value: $editVM.firstName, validation: editVM.fieldIsEmpty)
					SaiyanTextField(label: "Last Name", value: $editVM.lastName, validation: editVM.fieldIsEmpty)
				} header: {
					Text("Personal data")
						.textCase(.uppercase)
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		.padding()
		.customNavBar(title: "Edit employee")
    }
}

#Preview {
	EditEmployeeView(editVM: EditEmpleadosVM(empleado: .test))
		.environmentObject(EmpleadosVM(interactor: DataTestPreview()))
}
