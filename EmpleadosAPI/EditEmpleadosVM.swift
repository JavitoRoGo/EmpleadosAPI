//
//  EditEmpleadosVM.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

final class EditEmpleadosVM: ObservableObject {
	let empleado: Empleado
	
	@Published var firstName = ""
	@Published var lastName = ""
	@Published var email = ""
	@Published var username = ""
	@Published var address = ""
	@Published var zipcode = ""
	@Published var department = ""
	@Published var gender = ""
	
	@Published var error = false
	
	init(empleado: Empleado) {
		self.empleado = empleado
		initEmpleado()
	}
	
	func initEmpleado() {
		firstName = empleado.firstName
		lastName = empleado.lastName
		email = empleado.email
		username = empleado.username
		address = empleado.address
		zipcode = empleado.zipcode
		department = empleado.department.rawValue
		gender = empleado.gender.rawValue
	}
	
	func fieldIsEmpty(value: String) -> String? {
		if value.isEmpty {
			"cannot be empty"
		} else {
			nil
		}
	}
	// estas dos funciones las usamos como validación en el textfield custom Saiyan
	func emailIsNotValid(value: String) -> String? {
		let emailRegex = #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#
		do { // >iOS16
			let regex = try Regex(emailRegex)
			return if let _ = try regex.wholeMatch(in: value) {
				nil
			} else {
				"is not valid"
			}
		} catch {
			return "is not valid"
		}
//		emailRegex.range(of: value, options: .regularExpression) < iOS 15
	}
	
	func usernameValidation(value: String) -> String? {
		if value.isEmpty {
			"cannot be empty"
		} else if value.count > 10 {
			"cannot be greater than 10 characters"
		} else {
			nil
		}
	}
	
	func updatedEmpleado() -> Empleado? {
		guard let dpto = DptoName(rawValue: department),
			  let gender = Gender(rawValue: gender) else { return nil }
		return Empleado(
				id: empleado.id,
				firstName: firstName,
				lastName: lastName,
				email: email,
				username: username,
				address: address,
				zipcode: zipcode,
				avatar: empleado.avatar,
				department: dpto,
				gender: gender
		)
	}
}
