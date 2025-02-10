import SwiftUI

struct FinalQuestionView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var selectedOption: String?
    @State private var showFeedback = false
    @State private var feedbackMessage: String = ""
    @State private var shake = false
    
    let question = "Which document marked the end of the Mexican War of Independence?"
    let options = [
        "Treaty of Soledad",
        "Treaty of Córdoba",
        "Treaty of Guadalupe-Hidalgo"
    ]
    let correctAnswer = "Treaty of Córdoba"
    
    var body: some View {
        VStack(spacing: 30) {
            // Pregunta con estilo de texto grande y gamificado
            Text(question)
                .font(.system(size: 26, weight: .bold, design: .rounded))  // Más grande y en negrita
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(15)
                .background(Color.black)
                .cornerRadius(10)
                .shadow(radius: 10)  // Sombra para darle profundidad
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
            
            // Opciones de respuesta con retroalimentación visual
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .font(.system(size: 20, weight: .medium, design: .rounded))  // Tamaño más grande
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.gray.opacity(0.6)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 8)  // Sombra más notoria
                        .scaleEffect(selectedOption == option ? 1.05 : 1.0)  // Efecto de escala al seleccionar
                        .animation(.spring(), value: selectedOption)
                        .offset(x: selectedOption == option && selectedOption != correctAnswer && shake ? -10 : 0)  // Efecto de vibración si es incorrecto
                        .animation(
                            shake ? Animation.default.repeatCount(5).speed(4) : .default,
                            value: shake
                        )
                }
                .padding(.horizontal, 20)  // Espaciado más amplio para evitar que los botones se toquen
            }
            
            // Retroalimentación visual de si la respuesta es correcta o incorrecta
            if showFeedback {
                Text(feedbackMessage)
                    .font(.system(size: 22, weight: .bold, design: .rounded))  // Texto grande para la retroalimentación
                    .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)
                    .padding(12)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))  // Fondo oscuro con mayor opacidad para mejor enfoque
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 3)
        )
        .shadow(color: .gray, radius: 10, x: 5, y: 5)  // Sombra más profunda para dar efecto de profundidad
    }
    
    // Función que maneja la selección de respuesta
    private func handleAnswer(option: String) {
        selectedOption = option
        showFeedback = true
        feedbackMessage = option == correctAnswer ? "Correct!" : "Wrong!"
        
        if option == correctAnswer {
            viewModel.score += 30
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.gameState = .gameOver
            }
        } else {
            shake = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                shake = false
            }
        }
    }
}
