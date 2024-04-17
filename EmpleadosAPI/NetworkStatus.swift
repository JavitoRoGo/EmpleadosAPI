//
//  NetworkStatus.swift
//  EmpleadosAPI
//
//  Created by Javier Rodríguez Gómez on 17/4/24.
//

import Network
import SwiftUI

// Como esta app funciona 100% con datos de la nube, vamos a definir varios estados en función de la conexión y detectar si hay red o no

final class NetworkStatus: ObservableObject {
	enum Status {
		case offline, online, unknown
	}
	
	@Published var status = Status.online
	
	let monitor = NWPathMonitor()
	var queue = DispatchQueue(label: "MonitorNetwork") //se genera una cola serializada
	
	init() {
		monitor.start(queue: queue)
		monitor.pathUpdateHandler = { [self] path in
			// este closure se lanza cada vez que cambie el status del path o de la conexión
			DispatchQueue.main.async {
				// obligatoriamente hay que hacerlo así porque estamos en un contexto pre-async-await y hay que ejecutarlo sobre el hilo principal
				self.status = path.status != .unsatisfied ? .online : .offline
			}
		}
//		status = monitor.currentPath.status != .unsatisfied ? .online : .offline
	}
}
