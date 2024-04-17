//
//  AddToolBarButton.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

fileprivate struct AddToolBarButton: ViewModifier {
	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						
					} label: {
						Image(systemName: "plus")
							.symbolVariant(.circle)
							.symbolVariant(.fill)
					}
					.buttonStyle(.plain)
					.padding(5)
					.background {
						RoundedRectangle(cornerRadius: 10)
							.fill(Color(white: 0.9))
					}
				}
			}
	}
}

extension View {
	func addToolBarButton() -> some View {
		modifier(AddToolBarButton())
	}
}
