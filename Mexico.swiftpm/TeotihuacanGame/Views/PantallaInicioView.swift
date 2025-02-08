import SwiftUI

struct PantallaInicioView: View {
    @ObservedObject var estado: EstadoJuego
    @State private var showInstructions = false
    
    var body: some View {
        ZStack {
            Image("teotihua")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Welcome to Teotihuacán!")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Text("Your task is to gather the right materials and help build the Pyramid of the Sun. Let's go!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .font(.title2)
                
                Button("Start") {
                    self.showInstructions = true  
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
            
            // Si el juego no ha comenzado, muestra el modal de instrucciones
            if showInstructions {
                InstructionsModalteo(showInstructions: $showInstructions) {
                    estado.iniciarJuego()  // Inicia el juego
                }
            }
           
        }
    }
}

struct InstructionsModalteo: View {
    @Binding var showInstructions: Bool
    var onClose: () -> Void  // Acción cuando se cierra el modal
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showInstructions = false  // Cierra el modal si se toca afuera
                    onClose()  // Llama la función para iniciar el juego
                }
            
            VStack(spacing: 20) {
                Text("Instrucciones")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                Text("Encuentra las cabezas colosales ocultas en la selva y responde las preguntas correctamente para ganar.")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(20)
            .padding()
        }
    }
}

