//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 11/01/25.
//

import Foundation
import CoreGraphics
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameState: GameState = .introduction
    @Published var timeRemaining: Double = 40.0
    @Published var draggedCulture: Culture?
    private var lockedCultures: Set<UUID> = []
    
    private var timer: Timer?
    @Published var gameDuration: Double = 40.0
    
    @Published var cultures: [Culture]
    @Published var culturePositions: [UUID: CGPoint]
    @Published var score: Int = 0
    @Published var message: String? // Para almacenar el mensaje de resultado
    @Published var isCorrectPlacement: Bool = false // Para indicar si la colocación es correcta o incorrecta
    
    private var initialPositions: [UUID: CGPoint]
    
    init() {
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
    
    // Renombrado los parámetros para evitar ambigüedad
    func checkPlacement(cultureID id: UUID, location point: CGPoint, zoneName: String) -> Bool {
        guard let culture = cultures.first(where: { $0.id == id }) else { return false }
        
        let isCorrectZone = (zoneName == "Allies" && culture.isAlly) ||
                            (zoneName == "Non-Allies" && !culture.isAlly)
        
        isCorrectPlacement = isCorrectZone
        return isCorrectZone
    }
    
    func showMessage(message: String, isCorrect: Bool) {
        self.message = message
        self.isCorrectPlacement = isCorrect
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
    
    func randomizeCulturePositions() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for culture in cultures {
            let randomX = CGFloat.random(in: 50...(screenWidth - 50))
            let randomY = CGFloat.random(in: 100...(screenHeight - 200))
            culturePositions[culture.id] = CGPoint(x: randomX, y: randomY)
        }
    }
    
    func lockCulture(_ id: UUID) {
        lockedCultures.insert(id)
    }

    func isCultureLocked(_ id: UUID) -> Bool {
        return lockedCultures.contains(id)
    }
}
