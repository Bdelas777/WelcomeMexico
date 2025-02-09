import SwiftUI

struct QuizView: View {
    let question: String
    let options: [String]
    let correctAnswer: String
    @Binding var isVisible: Bool
    @Binding var isAnswered: Bool
    let onCorrectAnswer: () -> Void
    
    @State private var selectedOption: String?
    @State private var showFeedback = false
    @State private var feedbackMessage: String = ""
    @State private var shake = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question)
                .font(.custom("PressStart2P-Regular", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(10)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.brown, .yellow]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .font(.custom("PressStart2P-Regular", size: 12))
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .offset(x: selectedOption == option && selectedOption != correctAnswer && shake ? -5 : 0)
                        .animation(
                            shake ? Animation.default.repeatCount(5).speed(4) : .default,
                            value: shake
                        )
                }
            }
            
            if showFeedback {
                Text(feedbackMessage)
                    .font(.custom("PressStart2P-Regular", size: 14))
                    .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)
                    .padding(10)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.brown, .yellow]), startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(
            Image("OlmecStoneBackground") // Asegúrate de tener una imagen de fondo adecuada para darle el toque olmeca
                .resizable()
                .scaledToFill()
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 3)
        )
        .shadow(color: .gray, radius: 8, x: 4, y: 4)
    }
    
    private func handleAnswer(option: String) {
        selectedOption = option
        showFeedback = true
        feedbackMessage = option == correctAnswer ? "Correct!" : "Wrong!"
        
        if option == correctAnswer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isVisible = false
                isAnswered = true
                onCorrectAnswer()
            }
        } else {
            shake = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                shake = false
            }
        }
    }
}
