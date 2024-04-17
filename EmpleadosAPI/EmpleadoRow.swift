//
//  EmpleadoRow.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import SwiftUI

struct EmpleadoRow: View {
	let empleado: Empleado
	
    var body: some View {
		HStack{
			VStack(alignment: .leading) {
				Text(empleado.fullName)
					.font(.headline)
				Text(empleado.email)
					.font(.footnote)
					.foregroundStyle(.secondary)
					.padding(.bottom, 5)
				Text(empleado.username)
					.font(.caption)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.background {
			Rectangle()
				.fill(.background)
		}
    }
}

#Preview {
	EmpleadoRow(empleado: .test)
}
