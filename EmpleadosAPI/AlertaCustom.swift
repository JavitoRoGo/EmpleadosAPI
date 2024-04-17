//
//  AlertaCustom.swift
//  PrimeraAppSwiftUI
//
//  Created by Javier Rodríguez Gómez on 1/4/24.
//

import SwiftUI

fileprivate struct AlertaCustom: ViewModifier {
	@Binding var showCustom: Bool
	let title: String
	let msg: String
	
	func body(content: Content) -> some View {
		content
			.overlay {
				Rectangle()
					.ignoresSafeArea()
					.opacity(showCustom ? 0.7 : 0)
			}
			.overlay {
				VStack {
					Text(title)
						.bold()
					Text(msg)
					Button {
						showCustom.toggle()
					} label: {
						Text("Ok")
					}
				}
				.buttonStyle(.borderedProminent)
				.tint(.orange)
				.padding()
				.overlay {
					RoundedRectangle(cornerRadius: 10)
						.stroke(lineWidth: 3)
						.fill(.primary.opacity(0.4))
				}
				.background {
					RoundedRectangle(cornerRadius: 10)
						.fill(.green)
						.shadow(color: .primary.opacity(0.4), radius: 5, x: 0, y: 5)
				}
				.opacity(showCustom ? 1.0 : 0.0)
				.offset(y: showCustom ? 0 : 200)
			}
			.animation(.easeInOut, value: showCustom)
	}
}

extension View {
	func customAlert(showCustom: Binding<Bool>, title: String, msg: String) -> some View {
		modifier(AlertaCustom(showCustom: showCustom, title: title, msg: msg))
	}
}
