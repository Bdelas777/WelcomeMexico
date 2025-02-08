import SwiftUI

struct FinalQuestionView: View {
    @ObservedObject var viewModel: GameViewModelIndependence
    @State private var selectedAnswer: String?
    
    let question = "Which document marked the end of the Mexican War of Independence?"
    let options = [
        "Treaty of Soledad",
        "Treaty of Córdoba",
        "Treaty of Guadalupe-Hidalgo"
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text(question)
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        handleAnswer(option)
                    }) {
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .scaleEffect(selectedAnswer == nil ? 1.0 : 0.95)
                            .animation(.spring(), value: selectedAnswer)
                    }
                    .disabled(selectedAnswer != nil)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
    
    private func handleAnswer(_ answer: String) {
        selectedAnswer = answer
        viewModel.score += 30
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.gameState = .gameOver
        }
    }
}
