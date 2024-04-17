//
//  PreviewViews.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

extension ContentView {
	static var preview: some View {
		ContentView()
			.environmentObject(EmpleadosVM(interactor: DataTestPreview()))
	}
}
