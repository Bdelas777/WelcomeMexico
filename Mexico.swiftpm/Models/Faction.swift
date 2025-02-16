import Foundation
import SwiftUI

struct Faction: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
    let destination: AnyView
    static func ==(lhs: Faction, rhs: Faction) -> Bool {
           return lhs.id == rhs.id && lhs.name == rhs.name
       }
}

let factions = [
 Faction(
        name: "Olmecas",
        imageName: "Olmecas",
        description: "Uncover the origins of Mesoamerican civilization! The Olmecs, known as the 'Mother Culture,' invite you into a world of mystery and monumental art. Can you unravel the secrets behind their colossal stone heads?",
        destination: AnyView(OlmecGameView())
    ),
    Faction(
        name: "Teotihuacán",
        imageName: "teo",
        description: "Step into the majestic City of the Gods. Climb the towering Pyramid of the Sun and uncover the mysteries of Teotihuacán, where religion, science, and power collide. Are you ready to walk among giants?",
        destination: AnyView(JuegoPiramideView())
    ),
    Faction(
        name: "Tlaxcaltecas",
        imageName: "tlax",
        description: "Become a key strategist in shaping Mesoamerica's destiny. Join the Tlaxcaltecas, daring warriors who forged alliances that changed history forever. Will you dare to face the mighty Mexicas?",
        destination: AnyView(GameView())
    ),
    Faction(
        name: "Realistas",
        imageName: "realistas",
        description: "Experience the tension and drama of the fight for independence. Step into the shoes of the Realists, loyal to the Spanish crown, as they battle to preserve their cause. Can you hold your ground against the roar of revolution?",
        destination: AnyView(IndepeView())
    )
]
