//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import Foundation
import CoreGraphics

struct BloquePiramide: Identifiable {
    let id = UUID()
    var posicion: CGPoint
    var estaColocado = false
    var indiceZona: Int?
}
