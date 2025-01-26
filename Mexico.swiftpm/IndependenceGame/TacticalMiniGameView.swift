//
//  SwiftUIView.swift
//  
//
//  Created by Alumno on 12/01/25.
//

import SwiftUI

enum ArmyType: String {
    case realistic = "Realistic Army"
    case insurgent = "Insurgent Army"
}

struct TacticalMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var currentDecision: String?
    @State private var realisticArmyHealth: Int = 100
    @State private var insurgentArmyHealth: Int = 100
    @State private var playerHealth: Int = 100
    @State private var isPlayerTurn: Bool = true
    @State private var battleMessage: String = ""
    @State private var showEndGameModal: Bool = false
    @State private var endGameMessage: String = ""
    @State private var playerAction: String = ""
    @State private var enemyAction: String = ""

    let decisions = [
        ("Realistic Attack", "Defend"),
        ("Recover", "Wait")
    ]

    var body: some View {
        ZStack {
            Image("Indepe")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Battle Against the Insurgent Army!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()

                ProgressView("Insurgent Army", value: Float(insurgentArmyHealth), total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    .padding(.horizontal)

                ProgressView("Your Health (Realistic Army)", value: Float(playerHealth), total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    .padding(.horizontal)

                Text(battleMessage)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                HStack(spacing: 40) {
                    VStack {
                        Image("player")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .scaleEffect(playerAction == "Defend" ? 1.1 : 1)
                            .rotationEffect(.degrees(playerAction == "Attack" ? 30 : 0))
                            .animation(.easeInOut(duration: 0.3), value: playerAction)
                            .opacity(playerAction == "Recover" ? 0.7 : 1)
                            .animation(.easeInOut(duration: 0.3), value: playerAction)
                        Text("Player")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }

                    VStack {
                        Image("enemy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .scaleEffect(enemyAction == "Defend" ? 1.1 : 1)
                            .rotationEffect(.degrees(enemyAction == "Attack" ? -30 : 0))
                            .animation(.easeInOut(duration: 0.3), value: enemyAction)
                            .opacity(enemyAction == "Recover" ? 0.7 : 1)
                            .animation(.easeInOut(duration: 0.3), value: enemyAction)
                        Text("Enemy")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }

                ForEach(decisions, id: \ .0) { decision in
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
                battleMessage = "The battle begins... Choose your action."
            }
            .alert(isPresented: $showEndGameModal) {
                Alert(
                    title: Text("Game Over"),
                    message: Text(endGameMessage),
                    dismissButton: .default(Text("Continue")) {
                        viewModel.gameState = .finalQuestion
                    }
                )
            }
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
            isPlayerTurn = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                enemyTurn()
                isPlayerTurn = true
            }
        }
    }

    private func playerTurn(_ decision: String) {
        if decision == "Realistic Attack" {
            playerAction = "Attack"
            let damage = Int.random(in: 20...35)
            insurgentArmyHealth -= damage
            insurgentArmyHealth = max(insurgentArmyHealth, 0)
            battleMessage = "You attacked the Insurgent Army and dealt \(damage) damage!"

            if insurgentArmyHealth <= 0 {
                battleMessage = "You defeated the Insurgent Army!"
                endGame(with: "You won! The Insurgent Army has been defeated.")
            }
        } else if decision == "Recover" {
            playerAction = "Recover"
            let recovery = Int.random(in: 15...25)
            playerHealth += recovery
            playerHealth = min(playerHealth, 100)
            battleMessage = "You recovered \(recovery) health!"
        } else if decision == "Defend" {
            playerAction = "Defend"
            battleMessage = "You defended, minimizing damage!"
        } else if decision == "Wait" {
            playerAction = "Wait"
            battleMessage = "You wait for the enemy's next move."
        }
    }

    private func enemyTurn() {
        if insurgentArmyHealth > 0 {
            enemyAction = "Attack"
            let damage = Int.random(in: 10...20)
            playerHealth -= damage
            playerHealth = max(playerHealth, 0)
            battleMessage += "\nThe Insurgent Army attacked you and dealt \(damage) damage."

            if playerHealth <= 0 {
                battleMessage += "\nYou have been defeated!"
                endGame(with: "You lost! The Realistic Army has been defeated.")
            }
        }
    }

    private func endGame(with message: String) {
        endGameMessage = message
        showEndGameModal = true
    }
}
