//
//  EditEmployeeView.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

struct EditEmployeeView: View {
	@EnvironmentObject private var vm: EmpleadosVM
	@Environment(\.dismiss) var dismiss
	@ObservedObject var editVM: EditEmpleadosVM
	
	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading) {
				Section {
					SaiyanTextField(label: "First Name", value: $editVM.firstName, isError: $editVM.error, hint: AccesibilityHints.firstName, validation: editVM.fieldIsEmpty)
						.textContentType(.name)
					SaiyanTextField(label: "Last Name", value: $editVM.lastName, isError: $editVM.error, hint: AccesibilityHints.lastName, validation: editVM.fieldIsEmpty)
						.textContentType(.middleName)
					SaiyanTextField(label: "Address", value: $editVM.address, isError: $editVM.error, hint: AccesibilityHints.address, validation: editVM.fieldIsEmpty)
						.textContentType(.fullStreetAddress)
					SaiyanTextField(label: "ZIP code", value: $editVM.zipcode, isError: $editVM.error, hint: AccesibilityHints.zipcode, validation: editVM.fieldIsEmpty)
						.textContentType(.postalCode)
						.keyboardType(.numberPad)
					HStack(alignment: .firstTextBaseline) {
						Text("Gender")
							.bold()
							.padding(.bottom, 5)
							.accessibilityHidden(true)
						Spacer()
						Picker(selection: $editVM.gender) {
							ForEach(Gender.allCases) { gender in
								Text(gender.rawValue)
									.tag(gender.rawValue)
							}
						} label: {
							Text("Gender")
						}
					}
				}
				Section {
					SaiyanTextField(label: "email", value: $editVM.email, isError: $editVM.error, hint: AccesibilityHints.email, validation: editVM.emailIsNotValid)
						.textContentType(.emailAddress)
						.keyboardType(.emailAddress)
						.autocorrectionDisabled()
						.textCase(.lowercase)
						.textInputAutocapitalization(.never)
					SaiyanTextField(label: "Username", value: $editVM.username, isError: $editVM.error, hint: AccesibilityHints.email, validation: editVM.usernameValidation)
						.textContentType(.username)
						.autocorrectionDisabled()
						.textCase(.lowercase)
						.textInputAutocapitalization(.never)
					HStack(alignment: .firstTextBaseline) {
						Text("Department")
							.bold()
							.padding(.bottom, 5)
							.accessibilityHidden(true)
						Spacer()
						Picker(selection: $editVM.department) {
							ForEach(DptoName.allCases) { dpto in
								Text(dpto.rawValue)
									.tag(dpto.rawValue)
							}
						} label: {
							Text("Gender")
						}
					}
				} header: {
					Text("Corporate data")
						.textCase(.uppercase)
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		.padding()
		.customNavBar(title: "Edit employee")
		.saveToolBarButton(disabled: editVM.error) {
			if let empleado = editVM.updatedEmpleado() {
				Task(priority: .high) {
					if await vm.updateEmpleadoAPI(empleado) {
						vm.updateEmpleado(empleado)
						dismiss() // esto afecta a la interfaz y debería ir en MainActor, pero no hace falta porque está dentro de un Task que ya lo ejecuta en el hilo principal
					} else {
						// aquí va algún tipo de error para que el usuario sepa que ha fallado
					}
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		EditEmployeeView(editVM: EditEmpleadosVM(empleado: .test))
			.environmentObject(EmpleadosVM(interactor: DataTestPreview()))
	}
}
