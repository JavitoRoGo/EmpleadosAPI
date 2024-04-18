//
//  SaiyanTextField.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

struct SaiyanTextField: View {
//	enum Condition {
//		case notEmpty
//		case notValid
//		
//		var msg: String {
//			switch self {
//				case .notEmpty:
//					" cannot be empty."
//				case .notValid:
//					" is not valid."
//			}
//		}
//	}
	
	let label: String
	@Binding var value: String
	@Binding var isError: Bool
//	let condition: Condition
	var hint: String
	let validation: (String) -> String? // le pasamos este closure para poder utilizar otro tipo de validaciones y no solo si es empty
	
	@State var error = false
	@State var errorMessage = ""
	
//	var errorMsg: String {
//		"\(label+condition.msg)"
//	}
	
//	@Namespace var namespace // es para igualar a nivel de vista, distintos campos dentro de una misma agrupación, para conseguir que tengan un mismo identificador en diferentes estados. Es a nivel de vista, como para decirle al renderizador que dos vistas son la misma
	
    var body: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(label.capitalized)
				.bold()
				.padding(.bottom, 5)
				.accessibilityHidden(true)
//				.accessibilityLabeledPair(role: .label, id: label, in: namespace) // otra forma de hacer la accesibilidad, en pareja de label y content
			HStack {
				TextField("Enter the \(label.lowercased())", text: $value)
//					.accessibilityLabel(aLabel)
//					.accessibilityLabeledPair(role: .content, id: label, in: namespace)
					.accessibilityHint(hint)
					.accessibilityLabel(Text(label))
				Button {
					value = ""
				} label: {
					Image(systemName: "xmark")
						.symbolVariant(.fill)
						.symbolVariant(.circle)
				}
				.buttonStyle(.plain)
				.opacity(error ? 0 : 0.5)
				.accessibilityLabel(Text("\(label) delete value."))
				.accessibilityHint(Text("Tap this button to delete the value of the field."))
			}
			.padding(10)
			.overlay {
				RoundedRectangle(cornerRadius: 10)
					.stroke(lineWidth: 3)
					.fill(.red)
					.padding(2)
					.opacity(error ? 1 : 0)
			}
			.background {
				RoundedRectangle(cornerRadius: 10)
					.fill(.quaternary)
			}
			Text("\(label.capitalized) \(errorMessage).")
				.font(.caption2)
				.foregroundStyle(.red)
				.bold()
				.padding(.horizontal, 10)
				.opacity(error ? 1 : 0)
				.accessibilityLabel(Text("\(label) error message."))
				.accessibilityHint(Text("This is an error validation message for the field \(label). Fix the error to continue."))
		}
		.padding(.vertical, 5)
		.onChange(of: value, initial: true) {
			if let message = validation(value) {
				error = true
				errorMessage = message
			} else {
				error = false
				errorMessage = ""
			}
			isError = error
		}
    }
}
