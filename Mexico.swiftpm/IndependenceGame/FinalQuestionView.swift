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
        VStack(spacing: 20) {
            Text(question)
                .font(.custom("PressStart2P-Regular", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 2)
                )
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .font(.custom("PressStart2P-Regular", size: 12))
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 2)
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
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 3)
        )
        .shadow(color: .gray, radius: 5, x: 2, y: 2)
    }
    
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
