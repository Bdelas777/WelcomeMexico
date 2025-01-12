//
//  File.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import Foundation

struct Culture: Identifiable {
    let id = UUID()
    let name: String
    let isAlly: Bool
    let description: String
    let position: CGPoint
}
