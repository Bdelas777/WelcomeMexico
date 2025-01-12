//
//  File.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import Foundation
import CoreGraphics

class GameViewModel: ObservableObject {
    @Published var gameState: GameState = .introduction
    @Published var timeRemaining: Double = 40.0
    @Published var draggedCulture: Culture?
    
    private var timer: Timer?
    @Published var gameDuration: Double = 40.0
    
    @Published var cultures: [Culture]
    @Published var culturePositions: [UUID: CGPoint]
    @Published var score: Int = 0
    
    private var initialPositions: [UUID: CGPoint]
    
    init() {
        // Inicializamos cultures
        let initialCultures = [
            Culture(name: "Tlaxcaltecas", isAlly: true,
                    description: "The main allies of Cortés",
                    position: CGPoint(x: 100, y: 200)),
            Culture(name: "Mexicas", isAlly: false,
                    description: "The enemies of Cortés",
                    position: CGPoint(x: 200, y: 200)),
            Culture(name: "Totonacas", isAlly: false,
                    description: "Later supporters",
                    position: CGPoint(x: 300, y: 200))
        ]
        // Inicializamos todas las propiedades necesarias
        self.cultures = initialCultures
        let positions = Dictionary(uniqueKeysWithValues: initialCultures.map { ($0.id, $0.position) })
        self.culturePositions = positions
        self.initialPositions = positions
    }
    
    func updateCulturePosition(_ id: UUID, position: CGPoint) {
        culturePositions[id] = position
    }
    
    func resetCulturePosition(_ id: UUID) {
        if let initialPosition = initialPositions[id] {
            culturePositions[id] = initialPosition
        }
    }
    
    func checkPlacement(_ id: UUID, at point: CGPoint, in zone: String) -> Bool {
        guard let culture = cultures.first(where: { $0.id == id }) else { return false }
        
        let isCorrectZone = (zone == "Allies" && culture.isAlly) ||
                            (zone == "Non-Allies" && !culture.isAlly)
        return isCorrectZone
    }
    
    enum GameState {
        case introduction
        case playing
        case facts
        case victory
    }
    
    var progress: Double {
        return max(0.0, min(timeRemaining / gameDuration, 1.0))
    }
    
    func startGame() {
        timeRemaining = gameDuration
        gameState = .playing
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining = max(0, self.timeRemaining - 0.1)
            } else {
                self.timer?.invalidate()
                self.timeRemaining = 0
                self.showFacts()
            }
        }
    }
    
    func showFacts() {
        timer?.invalidate()
        gameState = .facts
    }
    
    func showVictory() {
        gameState = .victory
    }
    
    deinit {
        timer?.invalidate()
    }
}

