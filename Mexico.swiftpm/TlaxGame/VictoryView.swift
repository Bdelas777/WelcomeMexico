import SwiftUI

struct VictoryView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var animateStars = false
    @State private var isAppearing = false
    @State private var animateText = false
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
            Image("citytlax")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)
            
            // Fondo oscuro con opacidad
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // Título de victoria con animación
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
                
                // Descripción de victoria con fondo y borde
                Text("Thanks to your alliance, the Aztec Empire falls, and the Tlaxcaltecas secure their future!")
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: 500)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                
                // Dato curioso sobre los Tlaxcaltecas
                VStack(spacing: 20) {
                    Text("💡 Did you know?")
                        .font(.title)
                        .bold()
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                    
                    Text("The Tlaxcaltecas were instrumental in the Spanish conquest of the Aztec Empire, providing crucial military support to Hernán Cortés.")
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
                
                // Botón para regresar al menú principal con animación
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

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(viewModel: GameViewModel())
    }
}
