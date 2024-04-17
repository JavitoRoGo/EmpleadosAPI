//
//  SaiyanTextField.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

struct SaiyanTextField: View {
	enum Condition {
		case notEmpty
		case notValid
		
		var msg: String {
			switch self {
				case .notEmpty:
					" cannot be empty."
				case .notValid:
					" is not valid."
			}
		}
	}
	
	let label: String
	@Binding var value: String
	let condition: Condition
	let validation: (String) -> Bool // le pasamos este closure para poder utilizar otro tipo de validaciones y no solo si es empty
	
	var errorMsg: String {
		"\(label+condition.msg)"
	}
	
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			Text(label.capitalized)
				.bold()
			HStack {
				TextField("Enter the \(label.lowercased())", text: $value)
				Button {
					value = ""
				} label: {
					Image(systemName: "xmark")
						.symbolVariant(.fill)
						.symbolVariant(.circle)
				}
				.buttonStyle(.plain)
				.opacity(validation(value) ? 0 : 0.5)
			}
			.padding(10)
			.overlay {
				RoundedRectangle(cornerRadius: 10)
					.stroke(lineWidth: 3)
					.fill(.red)
					.padding(2)
					.opacity(validation(value) ? 1 : 0)
			}
			.background {
				RoundedRectangle(cornerRadius: 10)
					.fill(.quaternary)
			}
			if validation(value) {
				Text(errorMsg)
					.font(.caption)
					.foregroundStyle(.red)
					.bold()
					.padding(.horizontal, 10)
			}
		}
		.padding(.vertical, 5)
    }
}

#Preview {
	SaiyanTextField(label: "First name", value: .constant("Julio"), condition: .notEmpty) { _ in
		true
	}
}
