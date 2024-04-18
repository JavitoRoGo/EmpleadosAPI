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
		VStack(alignment: .leading) {
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
			Divider()
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.background {
			Rectangle()
				.fill(.background)
		}
		// recordar que si usamos un ScrollView con NavigationLink solo es pulsable la parte que tenga contenido, y por eso añadimos un fondo a todo lo ancho para que podamos pulsar en cualquier parte de la celda
    }
}

#Preview {
	EmpleadoRow(empleado: .test)
}
