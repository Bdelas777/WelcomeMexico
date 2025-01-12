//
//  File.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import Foundation

class GameViewModelIndependence: ObservableObject {
    @Published var gameState: GameState = .selecting
    @Published var timeRemaining: Int = 60
    @Published var score: Int = 0
    @Published var currentRoute: Route?
    @Published var showDialog = false
    @Published var gameMessage = ""
    
    let routes = [
        Route(name: "La Alianza",
              description: "Ruta segura: Negocia con Vicente Guerrero",
              difficulty: .safe,
              type: .alliance),
        Route(name: "Escape Nocturno",
              description: "Ruta peligrosa: Esquiva patrullas realistas",
              difficulty: .dangerous,
              type: .escape),
        Route(name: "Estrategia Militar",
              description: "Ruta peligrosa: Usa tácticas de distracción",
              difficulty: .dangerous,
              type: .tactical)
    ]
    
    var timer: Timer?
    
    func startGame(with route: Route) {
        currentRoute = route
        gameState = .playing
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            endGame()
        }
    }
    
    func endGame() {
        timer?.invalidate()
        gameState = .finalQuestion
    }
}
