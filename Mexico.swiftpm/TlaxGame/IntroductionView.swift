import SwiftUI

struct IntroductionView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        ZStack {
            Image("citytlax")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)

            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 25) {
                Text("Welcome to the Tlaxcaltec Journey!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("""
                The Tlaxcaltecs saw Cortés arrive and said, 'Freedom may be near.'
                
                Choose your allies wisely to free the Tlaxcaltecs from Aztec rule!
                """)
                    .font(.title)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("Place your allies in the green zone and enemies in the red zone to save the Tlaxcaltecs. Make sure to overlap the icons for validation!")
                    .font(.title2)
                    .foregroundColor(.yellow)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(maxWidth: 1000)

                Button(action: {
                    withAnimation {
                        viewModel.startGame()
                    }
                }) {
                    Text("Start the Game")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
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
}
