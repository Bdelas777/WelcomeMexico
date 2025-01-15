//
//  File.swift
//  
//
//  Created by Alumno on 14/01/25.
//

import Foundation

struct DistractingObject: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    
    static let sampleObjects = [
        DistractingObject(name: "Ancient Pottery", imageName: "pottery"),
        DistractingObject(name: "Jade Mask", imageName: "mask"),
        DistractingObject(name: "Stone Altar", imageName: "altar")
    ]
}
