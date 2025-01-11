//
//  File.swift
//  
//
//  Created by Alumno on 10/01/25.
//

import Foundation

struct Material {
    let name: String
    let imageName: String
    let fact: String
}

struct GameConstants {
    struct Materials {
        static let obsidian = Material(
            name: "Obsidian",
            imageName: "Obsidiana",
            fact: "This volcanic glass was used to make sharp tools and weapons!"
        )
        static let adobe = Material(
            name: "Adobe",
            imageName: "Adobe",
            fact: "Light and easy to transport, adobe was perfect for building in this vast city."
        )
        static let volcanicStone = Material(
            name: "VolcanicStone",
            imageName: "Piedra",
            fact: "Strong volcanic stone helped the pyramid stand for centuries."
        )
        static let lime = Material(
            name: "Lime",
            imageName: "Cal",
            fact: "Mixed with water, lime helped bind the stones together securely."
        )
    }

    static let allMaterials = [Materials.obsidian, Materials.adobe, Materials.volcanicStone, Materials.lime]
    static let introductionMessage = "Welcome to Teotihuacán! Your task is to gather the right materials and help build the Pyramid of the Sun. Let's go!"
    static let completionMessage = "Great job! You’ve helped build one of the largest pyramids in Mesoamerica."
    static let layerMessage = "This layer represents a vital part of the structure!"
}
