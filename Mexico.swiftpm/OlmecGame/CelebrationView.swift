import SwiftUI

struct CelebrationView: View {
    @Environment(\.dismiss) var dismiss
    let foundCount: Int
    let totalCount: Int
    let resetGame: () -> Void
    
    @State private var animateText = false
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("🎉 Congratulations! 🎉")
                    .font(.system(size: 55, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(color: .white, radius: 10)
                    .scaleEffect(animateText ? 1.1 : 1.0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            animateText.toggle()
                        }
                    }

                Text("You found \(foundCount) of \(totalCount) monumental stone heads!")
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
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
                    
                    Text("The Olmecs, known as the 'Mother Civilization' of Mesoamerica, were among the first to develop a writing system and a calendar. Their colossal stone heads, weighing up to 50 tons, are believed to represent powerful rulers.")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: 600)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(15)
                        .shadow(radius: 5)
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
                            LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
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

struct CelebrationView_Previews: PreviewProvider {
    static var previews: some View {
        CelebrationView(foundCount: 3, totalCount: 3, resetGame: {})
    }
}
