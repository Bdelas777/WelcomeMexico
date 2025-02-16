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
                .font(.system(size: 26, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.black.opacity(0.7))
                .cornerRadius(12)
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    handleAnswer(option: option)
                }) {
                    Text(option)
                        .font(.system(size: 20, weight: .bold))
                        .padding(14)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedOption == option ?
                            (selectedOption == correctAnswer ? Color.green : Color.red) :
                            Color.gray.opacity(0.8)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 2)
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
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)
                    .padding(12)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(
            ZStack {
              
                Color.black.opacity(0.6) 
            }
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 3)
        )
        .shadow(color: .black, radius: 10, x: 5, y: 5)
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
