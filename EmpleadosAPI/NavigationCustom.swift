//
//  NavigationCustom.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

fileprivate struct NavigationCustom: ViewModifier {
	let title: String
	
	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .principal) {
					HStack {
						Text(title)
							.font(.title2).bold()
						Spacer()
					}
					.padding(.vertical)
				}
			}
			.toolbarBackground(.visible, for: .navigationBar) // para mostrar siempre el background, también aplicable a la barra de tabView
			.onAppear {
				// hay que tocar las APIs de UIKit para cambiar el fondo de la barra de título, pero este código puede quedar obsoleto en cualquier momento
				UINavigationBar.appearance().backgroundColor = .red
				let red = UINavigationBarAppearance()
				red.backgroundColor = .red
				UINavigationBar.appearance().standardAppearance = red // esta no hace nada, solo funcionaría antes de iOS 15
				UINavigationBar.appearance().scrollEdgeAppearance = red // esta tampoco
			}
	}
}

extension View {
	func customNavBar(title: String) -> some View {
		modifier(NavigationCustom(title: title))
	}
}
