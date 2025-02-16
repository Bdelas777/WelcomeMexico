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
            Text(question)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(15)
                .background(Color.black)
                .cornerRadius(10)
                .shadow(radius: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
            

            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .font(.system(size: 20, weight: .medium, design: .rounded))                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.gray.opacity(0.6)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 8)
                        .scaleEffect(selectedOption == option ? 1.05 : 1.0) 
                        .animation(.spring(), value: selectedOption)
                        .offset(x: selectedOption == option && selectedOption != correctAnswer && shake ? -10 : 0)
                        .animation(
                            shake ? Animation.default.repeatCount(5).speed(4) : .default,
                            value: shake
                        )
                }
                .padding(.horizontal, 20)
            }
            
            if showFeedback {
                Text(feedbackMessage)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
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
        .background(Color.black.opacity(0.8))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 3)
        )
        .shadow(color: .gray, radius: 10, x: 5, y: 5)
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
