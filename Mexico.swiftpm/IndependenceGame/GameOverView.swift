import SwiftUI

struct GameOverView: View {
    let score: Int
    let isVictory: Bool
    @Environment(\.dismiss) var dismiss
    @State private var animateText = false
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text(isVictory ? "🏆 Victory! 🏆" : "🚫 Game Over! 🚫")
                    .font(.system(size: 55, weight: .bold, design: .rounded))
                    .foregroundColor(isVictory ? .yellow : .red)
                    .shadow(color: .white, radius: 10)
                    .scaleEffect(animateText ? 1.1 : 1.0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            animateText.toggle()
                        }
                    }
                
                Text("Final Score: \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 500)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    Text("💡 Did you know?")
                        .font(.title)
                        .bold()
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                    
                    Text("The Treaty of Córdoba in 1821 marked the end of the Mexican War of Independence. Mexico became free after a long conflict!")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: 600)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    
                    if isVictory {
                        Text("Agustín de Iturbide, a royalist leader, switched sides and joined the insurgents to achieve independence. He eventually became Mexico's first emperor!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: 600)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Return to Main Menu")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: 350)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                         startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .scaleEffect(animateButton ? 1.05 : 1.0)
                }
                .padding(.top, 40)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                        animateButton.toggle()
                    }
                }
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 40)
            .background(Color.black.opacity(0.85))
            .cornerRadius(25)
            .frame(maxWidth: 1400, maxHeight: 900)
        }
    }
}
