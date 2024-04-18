//
//  SaveToolBarButton.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 18/4/24.
//

import SwiftUI

fileprivate struct SaveToolBarButton: ViewModifier {
	var disabled: Bool
	let action: () -> Void
	
	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						action()
					} label: {
						Text("Save")
					}
					.buttonStyle(.plain)
					.padding(5)
					.background {
						RoundedRectangle(cornerRadius: 10)
							.fill(Color(white: 0.9))
					}
					.disabled(disabled)
				}
			}
	}
}

extension View {
	func saveToolBarButton(disabled: Bool = false, action: @escaping () -> Void) -> some View {
		modifier(SaveToolBarButton(disabled: disabled, action: action ))
	}
}
