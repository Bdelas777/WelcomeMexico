import SwiftUI

struct PantallaFinalView: View {
    @ObservedObject var estado: EstadoJuego
    @Environment(\.dismiss) var dismiss
    
    @State private var isAppearing = false
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

                Text("Amazing work! You've contributed to the creation of one of the grandest pyramids in all of Mesoamerica—a true marvel of ancient ingenuity!")
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: 500)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                
                Text("Final score: \(estado.puntuacion)")
                    .font(.title)
                    .foregroundColor(.white)
                    .scaleEffect(isAppearing ? 1 : 0.5)
                    .opacity(isAppearing ? 1 : 0)
                    .animation(.easeOut(duration: 0.7).delay(0.4), value: isAppearing)
                
                VStack(spacing: 20) {
                    Text("💡 Did you know?")
                        .font(.title)
                        .bold()
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                    
                    Text("The pyramids of Teotihuacan, one of the largest ancient cities in the Americas, were built with remarkable precision, using sophisticated engineering techniques that were ahead of their time.")
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
        .onAppear {
            isAppearing = true
        }
    }
}

struct PantallaFinalView_Previews: PreviewProvider {
    static var previews: some View {
        PantallaFinalView(estado: EstadoJuego())
    }
}

