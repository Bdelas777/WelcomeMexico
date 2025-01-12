//
//  File.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import Foundation


struct Question {
    let text: String
    let options: [DialogOption]
}

struct DialogOption: Identifiable {
    let id = UUID()  // Esto genera un identificador único para cada opción
    let text: String
    let nextQuestion: Int  // Índice de la siguiente pregunta o -1 si es el final
}
