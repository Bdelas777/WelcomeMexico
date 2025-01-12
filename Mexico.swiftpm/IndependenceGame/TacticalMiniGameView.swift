//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

// Enum para representar los tipos de ejércitos
enum ArmyType: String {
    case realistic = "Ejército Realista"
    case insurgent = "Ejército Insurgente"
}

struct TacticalMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var currentDecision: String?
    @State private var realisticArmyHealth: Int = 100
    @State private var insurgentArmyHealth: Int = 100
    @State private var playerHealth: Int = 100
    @State private var isPlayerTurn: Bool = true
    @State private var battleMessage: String = ""
    @State private var showEndGameModal: Bool = false  // Estado para mostrar el modal
    @State private var endGameMessage: String = ""     // Mensaje del modal
    
    let decisions = [
        ("Ataque Realista", "Defender"),
        ("Recuperar", "Esperar")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Batalla contra el Ejército Insurgente!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            ProgressView("Ejército Insurgente", value: Float(insurgentArmyHealth), total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                .padding(.horizontal)
            
            ProgressView("Tu vida (Ejército Realista)", value: Float(playerHealth), total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .padding(.horizontal)
            
            Text(battleMessage)
                .font(.body)
                .foregroundColor(.yellow)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)

            ForEach(decisions, id: \.0) { decision in
                HStack(spacing: 20) {
                    tacticalButton(decision.0, color: .blue)
                    tacticalButton(decision.1, color: .orange)
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .onAppear {
            battleMessage = "La batalla comienza... Elige tu ataque."
        }
        .alert(isPresented: $showEndGameModal) {  // Modal de fin de juego
            Alert(
                title: Text("Fin del juego"),
                message: Text(endGameMessage),
                dismissButton: .default(Text("Continuar")) {
                    viewModel.gameState = .finalQuestion  // Cambiar estado a endgame
                }
            )
        }
    }

    private func tacticalButton(_ text: String, color: Color) -> some View {
        Button(action: {
            handleDecision(text)
        }) {
            Text(text)
                .padding()
                .frame(width: 150)
                .background(color.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 5)
        }
        .scaleEffect(isPlayerTurn ? 1 : 0.95)
        .animation(.spring(), value: isPlayerTurn)
    }

    private func handleDecision(_ decision: String) {
        currentDecision = decision
        
        if isPlayerTurn {
            playerTurn(decision)
            isPlayerTurn = false // Cambio de turno
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Simula el tiempo de respuesta del enemigo
                enemyTurn()
                isPlayerTurn = true
            }
        }
    }
    
    private func playerTurn(_ decision: String) {
        if decision == "Ataque Realista" {
            let damage = Int.random(in: 20...35)
            insurgentArmyHealth -= damage
            insurgentArmyHealth = max(insurgentArmyHealth, 0)
            battleMessage = "¡Has atacado al Ejército Insurgente e infligido \(damage) de daño!"
            
            if insurgentArmyHealth <= 0 {
                battleMessage = "¡Has derrotado al Ejército Insurgente!"
                endGame(with: "¡Has ganado! El Ejército Insurgente ha sido derrotado.")
            }
        } else if decision == "Recuperar" {
            let recovery = Int.random(in: 15...25)
            playerHealth += recovery
            playerHealth = min(playerHealth, 100)
            battleMessage = "¡Has recuperado \(recovery) de salud!"
        } else if decision == "Defender" {
            battleMessage = "¡Te has defendido, minimizando el daño!"
        } else if decision == "Esperar" {
            battleMessage = "Esperas el siguiente ataque del enemigo."
        }
    }

    private func enemyTurn() {
        if insurgentArmyHealth > 0 {
            let damage = Int.random(in: 10...20)
            playerHealth -= damage
            playerHealth = max(playerHealth, 0)
            battleMessage += "\nEl Ejército Insurgente te ataca e inflige \(damage) de daño."
            
            if playerHealth <= 0 {
                battleMessage += "\n¡Has sido derrotado!"
                endGame(with: "¡Has perdido! El Ejército Realista ha sido derrotado.")
            }
        }
    }
    
    private func endGame(with message: String) {
        endGameMessage = message
        showEndGameModal = true
    }
}
