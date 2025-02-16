

import Foundation

struct ColossalHead: Identifiable {
    let id = UUID()
    let name: String
    let funFact: String
    let question: String
    let options: [String]
    let correctAnswer: String
    
    static let sampleHeads = [
        ColossalHead(
            name: "Head 1",
            funFact: "The Olmec colossal heads were made of basalt and weighed up to 50 tons!",
            question: "What material were the heads made of?",
            options: ["A) Clay", "B) Basalt", "C) Gold"],
            correctAnswer: "B) Basalt"
        ),
        ColossalHead(
            name: "Head 2",
            funFact: "The Olmecs were skilled at carving massive stones from distant quarries!",
            question: "What skill were the Olmecs famous for?",
            options: ["A) Pottery", "B) Stone Carving", "C) Painting"],
            correctAnswer: "B) Stone Carving"
        ),
        ColossalHead(
            name: "Head 3",
            funFact: "The Olmecs created one of the first writing systems in Mesoamerica!",
            question: "What was one of the Olmec's innovations?",
            options: ["A) Writing", "B) Music", "C) Medicine"],
            correctAnswer: "A) Writing"
        )
    ]
}
