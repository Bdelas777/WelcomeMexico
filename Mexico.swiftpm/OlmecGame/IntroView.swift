
import SwiftUI

struct IntroView: View {
    @Binding var showIntro: Bool
    let startGame: () -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Welcome to the Olmec Jungle!")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("""
            Your adventure begins in the heart of Mesoamerica, where the Olmec civilization once thrived.
            
            Three colossal Olmec heads are hidden deep within the jungle. To unlock each one, you must answer a question correctly.
            
            Can you uncover the secrets of the ancient Olmecs?
            """)
                .font(.title)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                withAnimation {
                    showIntro = false
                    startGame()
                }
            }) {
                Text("Begin Your Quest")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                       startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
        }
        .padding()
        .background(Color.black.opacity(0.85))
        .cornerRadius(20)
        .padding()
    }
}
