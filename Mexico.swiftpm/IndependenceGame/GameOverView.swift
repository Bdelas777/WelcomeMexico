import SwiftUI

struct GameOverView: View {
    let score: Int
    let isVictory: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: isVictory ? [Color.green, Color.blue] : [Color.red, Color.black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text(isVictory ? "🏆 ¡Victoria! 🏆" : "🚫 ¡Fin del Juego! 🚫")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5, x: 0, y: 5)

                        Text("Puntuación Final: \(score)")
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("El Tratado de Córdoba en 1821 marcó el fin de la Guerra de Independencia de México. ¡México se hizo libre tras un largo conflicto!")
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .foregroundColor(.white)

                            if isVictory {
                                Text("Agustín de Iturbide, un líder realista, cambió de bando y se unió a los insurgentes para lograr la independencia. ¡Finalmente se convirtió en el primer emperador de México!")
                                    .multilineTextAlignment(.center)
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)

                        Button(action: {
                            dismiss()
                        }) {
                            Text("Volver al menú principal")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        .padding([.leading, .trailing], 20)
                    }
                    .padding()
                }
            }
        }
