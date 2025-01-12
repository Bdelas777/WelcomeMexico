//
//  File.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import Foundation

struct DialogOption: Identifiable {
    let id = UUID()
    let text: String
    let isCorrect: Bool
    let explanation: String
}
