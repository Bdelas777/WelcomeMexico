import SwiftUI

struct TacticalMiniGameView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var currentDecision: String?
    @State private var realisticArmyHealth = 100
    @State private var insurgentArmyHealth = 100
    @State private var playerHealth = 100
    @State private var isPlayerTurn = true
    @State private var battleMessage = ""
    @State private var showEndGameModal = false
    @State private var endGameMessage = ""
    @State private var playerAction = ""
    @State private var enemyAction = ""
    @State private var showActionEffect = false
    

    let decisions = [
        ("Attack", "Defend"),
        ("Recover", "Wait")
    ]

    var body: some View {
        ZStack {
            Image("Indepe")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.5))

            VStack(spacing: 30) {
                // Title and Health Bars Section
                VStack(spacing: 20) {
                    Text("Battle for Independence")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.yellow)
                        .shadow(color: .black, radius: 5)

                    healthBars
                }

                // Battle Message Display
                battleMessageView
                
                // Character Images (Player vs Enemy)
                characterDisplay

                // Action Buttons Section
                actionButtons
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(30)
            .shadow(radius: 15)
            .padding()

            if showActionEffect {
                actionEffectOverlay
            }
        }
        .alert(isPresented: $showEndGameModal) {
            Alert(
                title: Text("Battle Concluded"),
                message: Text(endGameMessage),
                dismissButton: .default(Text("Continue")) {
                    viewModel.gameState = .finalQuestion
                }
            )
        }
        .onAppear {
            battleMessage = "Choose your strategy wisely, Commander."
        }
    }

    private var healthBars: some View {
        VStack(spacing: 15) {
            healthBar(label: "Enemy Forces", value: insurgentArmyHealth, color: .red)
            healthBar(label: "Your Forces", value: playerHealth, color: .green)
        }
    }

    private func healthBar(label: String, value: Int, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .foregroundColor(.white)
                .font(.title3)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))

                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(value) / 100)
                }
            }
            .frame(height: 20)
            .cornerRadius(12)
            .overlay(
                Text("\(value)%")
                    .foregroundColor(.white)
                    .font(.headline)
            )
        }
    }

    private var battleMessageView: some View {
        Text(battleMessage)
            .font(.title3)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(20)
    }

    private var characterDisplay: some View {
        HStack(spacing: 60) {
            characterImage("player", action: playerAction, label: "Your Forces")
            characterImage("enemy", action: enemyAction, label: "Enemy")
        }
        .padding(.top, 20)
    }

    private func characterImage(_ image: String, action: String, label: String) -> some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .scaleEffect(action == "Defend" ? 1.1 : 1)
                .rotationEffect(.degrees(action == "Attack" ? (image == "player" ? 30 : -30) : 0))
                .opacity(action == "Recover" ? 0.7 : 1)
                .animation(.easeInOut(duration: 0.3), value: action)

            Text(label)
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top, 10)
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 20) {
            ForEach(decisions, id: \.0) { decision in
                HStack(spacing: 20) {
                    tacticalButton(decision.0)
                    tacticalButton(decision.1)
                }
            }
        }
        .padding(.top, 30)
    }

    private func tacticalButton(_ text: String) -> some View {
        Button(action: { handleDecision(text) }) {
            Text(text)
                .font(.title3)
                .bold()
                .frame(width: 160)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .disabled(!isPlayerTurn)
        .opacity(isPlayerTurn ? 1 : 0.6)
    }

    private var actionEffectOverlay: some View {
        Color.white
            .opacity(0.3)
            .edgesIgnoringSafeArea(.all)
            .transition(.opacity)
    }

    private func handleDecision(_ decision: String) {
        currentDecision = decision

        if isPlayerTurn {
            playerTurn(decision)
            isPlayerTurn = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if insurgentArmyHealth > 0 {  // Solo permite que el enemigo juegue si sigue vivo
                    enemyTurn()
                }
                isPlayerTurn = true
            }
        }
    }

    private func playerTurn(_ decision: String) {
        if decision == "Attack" {
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
