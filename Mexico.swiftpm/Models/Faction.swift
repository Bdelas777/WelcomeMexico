//
//  File.swift
//  
//
//  Created by Alumno on 09/01/25.
//

import Foundation

struct Faction: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
}

// Faction list
let factions = [
    Faction(name: "Olmecs", imageName: "olmec", description: "Known as the 'Mother Culture' of Mesoamerica. Famous for their colossal heads carved from basalt."),
    Faction(name: "Teotihuacán", imageName: "teo", description: "A massive city and religious center. Famous for its pyramids, including the Pyramid of the Sun."),
    Faction(name: "Tlaxcaltecas", imageName: "tlax", description: "Allied with Hernán Cortés to defeat the Mexicas/Aztecs. Key players in the Spanish conquest."),
    Faction(name: "Realistas", imageName: "goal", description: "Loyalists who opposed Mexican independence. Played a crucial role during the War of Independence.")
]
