//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import Foundation

struct Material: Identifiable {
    let id = UUID()
    let nombre: String
    let descripcion: String
    let esCorrectoParaPiramide: Bool
}
