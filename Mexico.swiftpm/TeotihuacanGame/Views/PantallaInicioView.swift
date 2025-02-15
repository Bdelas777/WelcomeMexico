
import SwiftUI

struct PantallaInicioView: View {
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Welcome to Teotihuacán!")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("""
            Gather all the materials needed to build the Pyramid of the Sun.
            Once ready, begin constructing this magnificent monument!
            """)
                .font(.title)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            

            Button(action: {
                withAnimation {
                    estado.iniciarJuego()
                }
            }) {
                Text("Start Gathering Materials")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
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
